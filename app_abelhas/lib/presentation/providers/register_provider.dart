// core/providers/auth_provider.dart
import 'package:app_abelhas/data/models/user_model.dart';
import 'package:app_abelhas/data/repositories/auth_repository_impl.dart';
import 'package:flutter/material.dart';

class RegisterProvider with ChangeNotifier {
  final AuthRepository _authRepository;
  RegisterProvider({required AuthRepository authRepository})
      : _authRepository = authRepository;

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> signUp(UserModel user) async {
    _setLoading(true);
    await Future.delayed(Duration(seconds: 2));
    _errorMessage = null;

    final result = await _authRepository.signUp(user);

    result.fold(
      (failure) {
        _errorMessage = failure.message;
      },
      (_) {
        _errorMessage = null;
      },
    );

    _setLoading(false);
    return _errorMessage == null;
  }

  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    _errorMessage = null;

    final result = await _authRepository.signIn(email, password);

    result.fold(
      (failure) {
        _errorMessage = failure.message;
      },
      (_) {
        _errorMessage = null;
      },
    );

    _setLoading(false);
    return _errorMessage == null;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
