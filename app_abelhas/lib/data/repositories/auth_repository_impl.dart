import 'package:app_abelhas/core/auth/auth_state_notifier.dart';
import 'package:app_abelhas/core/errors/failures.dart';
import 'package:app_abelhas/core/services/firebase_messaging_service.dart';
import 'package:app_abelhas/data/datasources/auth_remote_datasource.dart';
import 'package:dartz/dartz.dart';

import '../models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> signUp(UserModel user);
  Future<Either<Failure, void>> signIn(String email, String password);
  Future<UserModel?> getUserProfile();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _authDatasource;
  final AuthStateNotifier authStateNotifier;
  final AbstractFirebaseMessagingService firebaseMessagingService;

  AuthRepositoryImpl(this._authDatasource, this.firebaseMessagingService,
      this.authStateNotifier);

  @override
  Future<Either<Failure, void>> signUp(UserModel user) async {
    try {
      final fcmToken = await firebaseMessagingService.getFirebaseToken() ?? '';
      await _authDatasource.signUp(user, fcmToken);
      authStateNotifier.changeState(user);
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signIn(String email, String password) async {
    try {
      final fcmToken = await firebaseMessagingService.getFirebaseToken() ?? '';
      await _authDatasource.signIn(email, password, fcmToken);
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<UserModel?> getUserProfile() {
    return _authDatasource.getUserProfile();
  }
}
