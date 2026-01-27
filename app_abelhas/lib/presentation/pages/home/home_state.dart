part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class LoadingMap extends HomeState {}

class MapLoaded extends HomeState {}

class PermissionError extends HomeState {}

class ShowMessageToRegisterPlace extends HomeState {
  final String message;

  ShowMessageToRegisterPlace({required this.message});
}

class CancelRegister extends HomeState {}

class ResgisteringPlace extends HomeState {}

class LoadingResgisteringPlace extends HomeState {}

class PlaceRegisteredSuccess extends HomeState {}

class PulverizationRegisteredSuccess extends HomeState {}

class PlaceRegisteredError extends HomeState {}

class VerifySafeAgrotoxicError extends HomeState {}

class VerifySafeAgrotoxicAlert extends HomeState {
  final String numBeehives;

  VerifySafeAgrotoxicAlert({required this.numBeehives});
}

class CancelPlaceRegistered extends HomeState {}

class ShowBeehiveInfo extends HomeState {
  final BeehiveModel beehive;

  ShowBeehiveInfo({required this.beehive});
}

class RegisteredPlace extends HomeState {
  final Circle circle;
  final Marker marker;

  RegisteredPlace({required this.circle, required this.marker});
}

class ChangePageView extends HomeState {
  final int page;

  ChangePageView({required this.page});
}

class RadiusUpdated extends HomeState {}

class GetNotificationsError extends HomeState {}

class GetNotificationsLoaded extends HomeState {}

class GetNotificationsLoading extends HomeState {}
