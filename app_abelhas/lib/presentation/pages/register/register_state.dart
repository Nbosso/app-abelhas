part of 'register_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginError extends LoginState {}

class RedirectToPage extends LoginState {
  final String route;

  RedirectToPage({required this.route});
}
