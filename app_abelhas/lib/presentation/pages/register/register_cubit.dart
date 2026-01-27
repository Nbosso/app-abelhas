import 'package:app_abelhas/core/auth/auth_state_notifier.dart';
import 'package:app_abelhas/data/repositories/auth_repository_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'register_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;
  final AuthStateNotifier authStateNotifier;

  LoginCubit({required this.authRepository, required this.authStateNotifier})
      : super(LoginInitial());

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    await Future.delayed(Durations.extralong4);

    try {
      final result = await authRepository.signIn(email, password);
      if (result.isRight()) {
        final user = await authRepository.getUserProfile();
        if (user != null) {
          authStateNotifier.changeState(user);
          emit(RedirectToPage(route: '/home'));
        } else {
          emit(LoginError());
        }
      } else {}
    } on AuthException catch (e) {
      debugPrint('Erro de autenticação: ${e.message}');
      emit(LoginError());
    } finally {
      _isLoading = false;
    }
  }
}
