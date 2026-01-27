import 'package:app_abelhas/core/services/supabase_service.dart';
import 'package:app_abelhas/data/models/user_model.dart';

class AuthDatasource {
  final SupabaseService _supabaseService;

  AuthDatasource(this._supabaseService);
  Future<void> signUp(UserModel user, String fcmToken) async {
    final response = await _supabaseService.client.auth.signUp(
      email: user.email,
      password: user.password,
      data: user.toJson(),
    );

    final userId = response.user?.id;

    if (userId == null) {
      throw Exception('Erro ao registrar usuário.');
    }

    // Armazena os dados adicionais em uma tabela "users"
    await _supabaseService.client.from('users').insert({
      'id': userId,
      'name': user.name,
      'birth_date': user.birthDate?.toIso8601String(),
      'type': user.type,
      'phone': user.phone,
      'gender': 'Masculino',
      'email': user.email
    });

    await _supabaseService.client.from('user_devices').insert({
      'fcm_token': fcmToken,
    });
  }

  Future<void> signIn(String email, String password) async {
    final response = await _supabaseService.client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception('Erro ao fazer login. Verifique suas credenciais.');
    }
  }

  Future<void> signOut() async {
    await _supabaseService.client.auth.signOut();
  }

  Future<UserModel?> getUserProfile() async {
    final userId = _supabaseService.client.auth.currentUser?.id;

    if (userId == null) return null;

    final response = await _supabaseService.client
        .from('users')
        .select()
        .eq('id', userId)
        .single();

    return UserModel.fromMap(response);
  }
}
