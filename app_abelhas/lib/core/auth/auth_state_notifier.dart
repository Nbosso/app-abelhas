import 'package:app_abelhas/data/models/user_model.dart';
import 'package:flutter/foundation.dart';

class AuthStateNotifier extends ChangeNotifier {
  UserModel? user;

  bool get isAuthenticated => user != null;

  void changeState(UserModel? user) {
    this.user = user;
    notifyListeners();
  }
}
