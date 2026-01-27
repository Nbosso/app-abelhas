import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;

  late final SupabaseClient client;

  SupabaseService._internal() {
    final url = dotenv.env['SUPABASE_URL'];
    final anonKey = dotenv.env['SUPABASE_ANON_KEY'];

    if (url == null || anonKey == null) {
      throw Exception('Supabase URL ou Anon Key não foram definidas no .env');
    }

    client = SupabaseClient(url, anonKey,
        authOptions:
            const AuthClientOptions(authFlowType: AuthFlowType.implicit));
  }

  Future<bool> isLogged() async {
    final user = client.auth.currentUser;
    return user != null;
  }
}
