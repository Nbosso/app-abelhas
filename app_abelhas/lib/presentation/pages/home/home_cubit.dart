import 'dart:math' show asin, atan2, cos, pi, sin;

import 'package:app_abelhas/core/auth/auth_state_notifier.dart';
import 'package:app_abelhas/core/services/location_service.dart';
import 'package:app_abelhas/data/models/affected_beehive.dart';
import 'package:app_abelhas/data/models/apicultor_area.dart';
import 'package:app_abelhas/data/models/beehive_model.dart';
import 'package:app_abelhas/data/models/notification_model.dart';
import 'package:app_abelhas/data/models/user_model.dart';
import 'package:app_abelhas/data/repositories/auth_repository_impl.dart';
import 'package:app_abelhas/data/repositories/beehive_repository_impl.dart';
import 'package:app_abelhas/data/repositories/spray_area_repository_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AuthRepository authRepository;
  final BeehiveRepository beehiveRepository;
  final SprayAreaRepository sprayAreaRepository;
  final AuthStateNotifier authStateNotifier;
  final LocationService locationService;

  HomeCubit(
      {required this.authRepository,
      required this.beehiveRepository,
      required this.sprayAreaRepository,
      required this.authStateNotifier,
      required this.locationService})
      : super(HomeInitial()) {
    getNotifications();
  }

  void showMessageToRegisterPlace() {
    var message = user.type == 'Apicultor'
        ? 'Selecione um local no mapa para registrar um apiário.'
        : 'Selecione o centro e o raio da sua área de aplicação no mapa.';
    emit(ShowMessageToRegisterPlace(message: message));
  }

  void cancelRegisterPlace() {
    beehives.remove(beehives.last);
    markers.remove(markers.last);
    emit(CancelPlaceRegistered());
  }

  void cancelRegisterAgrotoxic() {
    markers.remove(markers.last);
    circles.remove(circles.last);
    emit(CancelPlaceRegistered());
  }

  String? grupoRisco;
  void onChangeGrupoRisco(v) => grupoRisco = v;
  String? tipoAgrotoxico;
  void onChangeTipo(v) => tipoAgrotoxico = v;

  int _index = 0;

  int get currentIndex => _index;

  void changeTab(int newIndex) {
    _index = newIndex;
    emit(ChangePageView(page: newIndex));
  }

  bool selectNotificationsIsEnabled = false;
  bool isSelectAllNotifications = false;
  List<String> selectedNotifications = [];

  // Map<String, List<NotificationEntity>> notifications = {};
  List<NotificationModel> notifications = [];

  UserModel get user => authStateNotifier.user!;

  LatLng? currentPosition;
  GoogleMapController? mapController;

  final markers = <Marker>{
    // Marker(
    //     markerId: MarkerId('0'),
    //     position: LatLng(-25.444215603597737, -49.286723169203235),
    //     infoWindow: InfoWindow(title: 'Praça do Japão')),
    // Marker(
    //     markerId: MarkerId('1'),
    //     position: LatLng(-25.424368233959687, -49.30732703746026),
    //     infoWindow: InfoWindow(title: 'Parque Barigui')),
  };

  final circles = <Circle>{};

  final beehives = <Polygon>{};

  double _radius = 500; // metros
  double get radius => _radius;

  void onMapCreatedRegistration(
    GoogleMapController controller, {
    required LatLng coordenadas,
  }) async {
    mapController = controller;
    await Future.delayed(Duration(seconds: 1));
    _updateCircle();
  }

  void updateRadius(double value) {
    _radius = value;
    _updateCircle();
    emit(RadiusUpdated()); // força rebuild
  }

  void _updateCircle() {
    circles
      ..clear()
      ..add(
        Circle(
          circleId: const CircleId('application_radius'),
          center: markers.last.position,
          radius: _radius,
          fillColor: Colors.red.withOpacity(0.25),
          strokeColor: Colors.red,
          strokeWidth: 2,
        ),
      );
  }

  Future<void> loadMap() async {
    emit(LoadingMap());
    if (currentPosition == null) {
      final position = await locationService.getCurrentPosition();
      if (position != null) {
        currentPosition = LatLng(position.latitude, position.longitude);
      } else {
        print('Permissão negada ou serviço desativado');
        emit(PermissionError());
        return;
      }
    }

    await getUserBeehives();
    emit(MapLoaded());
  }

  void onMapCreated(GoogleMapController controller, {LatLng? coordenadas}) {
    mapController ?? controller;
    if (currentPosition != null) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: coordenadas ?? currentPosition!, zoom: 15),
        ),
      );
    }
  }

  void addPlaceOnMap(LatLng coordenadas, {String title = ''}) {
    markers.add(Marker(
        markerId: MarkerId(
          (markers.length + 1).toString(),
        ),
        position: coordenadas,
        infoWindow: InfoWindow(
          title: title,
        )));
    if (user.type != 'Apicultor') return;

    final List<LatLng> pontosHexagono = _gerarHexagono(coordenadas, 3000);

    beehives.add(Polygon(
      polygonId: PolygonId((beehives.length + 1).toString()),
      points: pontosHexagono,
      fillColor: Colors.orange.withOpacity(0.3),
      strokeColor: Colors.orange,
      strokeWidth: 2,
    ));
  }

  void removePlaceOnMap() {
    markers.remove(markers.last);
    if (beehives.isEmpty) return;
    beehives.remove(beehives.last);
  }

  Future<void> registerPlace(BeehiveModel beehive) async {
    markers.last.copyWith();
    beehives.last.copyWith();
    emit(LoadingResgisteringPlace());
    final result = await beehiveRepository.save(beehive);
    result.fold((f) {
      removePlaceOnMap();
      emit(PlaceRegisteredError());
    }, (r) {
      emit(PlaceRegisteredSuccess());
      loadMap();
    });
  }

  SprayArea? _sprayArea;
  List<AffectedBeehive>? _affectedBeehives;
  Future<void> confirmPulverization({SprayArea? sprayArea}) async {
    emit(LoadingResgisteringPlace());
    markers.last.copyWith();
    final result = await sprayAreaRepository.confirmPulverization(
        sprayArea ?? _sprayArea!, _affectedBeehives ?? []);
    result.fold((f) {
      removePlaceOnMap();
      emit(PlaceRegisteredError());
    }, (r) {
      emit(PulverizationRegisteredSuccess());
      loadMap();
    });
    _sprayArea = null;
    _affectedBeehives?.clear();
    markers.clear();
    circles.clear();
  }

  Future<void> verifySafeAgrotoxic(SprayArea sprayArea) async {
    emit(LoadingResgisteringPlace());
    final result = await beehiveRepository.verifySafeAgrotoxic(sprayArea);
    result.fold((f) {
      emit(VerifySafeAgrotoxicError());
    }, (r) {
      if (r.isEmpty) {
        confirmPulverization(sprayArea: sprayArea);
      } else {
        _affectedBeehives = List.from(r);
        _sprayArea = sprayArea;
        emit(VerifySafeAgrotoxicAlert(numBeehives: r.length.toString()));
      }
    });
  }

  Future<void> getUserBeehives() async {
    final result = await beehiveRepository.getUserBeehives();
    result.fold((f) {
      // emit(PlaceRegisteredError());
    }, (r) {
      for (var element in r) {
        addPlaceOnMap(
            LatLng(double.parse(element.lat), double.parse(element.lng)),
            title: element.register);
      }
      // emit(PlaceRegisteredSuccess());
    });
  }

  void registeringPlace() {
    emit(ResgisteringPlace());
  }

  List<LatLng> _gerarHexagono(LatLng centro, double raioMetros) {
    const int lados = 6;
    const double grauPorLado = 360 / lados;
    const double raioTerra = 6371000; // em metros

    final double lat = centro.latitude * pi / 180;
    final double lng = centro.longitude * pi / 180;
    final double d = raioMetros / raioTerra;

    List<LatLng> pontos = [];

    for (int i = 0; i < lados; i++) {
      final double angulo = grauPorLado * i * pi / 180;

      final double latPonto =
          asin(sin(lat) * cos(d) + cos(lat) * sin(d) * cos(angulo));
      final double lngPonto = lng +
          atan2(
            sin(angulo) * sin(d) * cos(lat),
            cos(d) - sin(lat) * sin(latPonto),
          );

      pontos.add(LatLng(
        latPonto * 180 / pi,
        lngPonto * 180 / pi,
      ));
    }

    // Fecha o polígono conectando o último ponto ao primeiro
    pontos.add(pontos.first);

    return pontos;
  }

  String version = '1.0.0';

  Future<void> getAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      version = '${packageInfo.version} (${packageInfo.buildNumber})';
    } catch (exception) {
      // throw Exception();
    }
  }

  Future<void> getNotifications() async {
    emit(GetNotificationsLoading());
    await Future.delayed(Duration(seconds: 1));
    final result = await sprayAreaRepository.getNotifications();
    result.fold((f) {
      emit(GetNotificationsError());
    }, (r) {
      notifications.addAll(r);
      emit(GetNotificationsLoaded());
    });
  }
}
