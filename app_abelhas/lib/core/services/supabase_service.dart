import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient client;

  SupabaseService(this.client);

  Future<User?> isLogged() async {
    return client.auth.currentUser;
  }
}
