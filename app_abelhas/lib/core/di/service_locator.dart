import 'package:app_abelhas/core/auth/auth_state_notifier.dart';
import 'package:app_abelhas/core/services/firebase_messaging_service.dart';
import 'package:app_abelhas/core/services/location_service.dart';
import 'package:app_abelhas/core/services/supabase_service.dart';
import 'package:app_abelhas/data/datasources/auth_remote_datasource.dart';
import 'package:app_abelhas/data/datasources/beehive_remote_datasource.dart';
import 'package:app_abelhas/data/datasources/spray_area_remote_datasource.dart';
import 'package:app_abelhas/data/repositories/auth_repository_impl.dart';
import 'package:app_abelhas/data/repositories/beehive_repository_impl.dart';
import 'package:app_abelhas/data/repositories/spray_area_repository_impl.dart';
import 'package:app_abelhas/presentation/pages/home/home_cubit.dart';
import 'package:app_abelhas/presentation/pages/login/login_cubit.dart';
import 'package:app_abelhas/presentation/providers/register_provider.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  _registerAuthNotifierDependencies();
  await _registerServicesDependencies();

  // final supabase = Supabase.instance;
  // getIt.registerLazySingleton<Supabase>(() => supabase);

  // Presentation Layer
  getIt.registerFactory(() => HomeCubit(
      authRepository: getIt(),
      beehiveRepository: getIt(),
      sprayAreaRepository: getIt(),
      authStateNotifier: getIt(),
      locationService: getIt()));
  getIt.registerFactory(
      () => LoginCubit(authRepository: getIt(), authStateNotifier: getIt()));

  // // Domain Layer
  // sl.registerFactory(() => RegisterUseCase(sl()));
  // sl.registerFactory(() => LoginUseCase(sl()));
  getIt.registerFactory<RegisterProvider>(
    () => RegisterProvider(authRepository: getIt()),
  );
  // // Data Layer
  // sl.registerLazySingleton<AuthRepository>(
  //   () => AuthRepositoryImpl(remoteDataSource: sl()),
  // );
  // sl.registerLazySingleton<AuthRemoteDataSource>(
  //   () => AuthRemoteDataSourceImpl(dio: sl()),
  // );
  // DataSources
  getIt.registerLazySingleton<AuthDatasource>(
    () => AuthDatasource(getIt()),
  );
  getIt.registerLazySingleton<BeehiveDatasource>(
    () => BeehiveDatasource(getIt()),
  );
  getIt.registerLazySingleton<SprayAreaDatasource>(
    () => SprayAreaDatasource(getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt(), getIt(), getIt()),
  );
  getIt.registerLazySingleton<BeehiveRepository>(
    () => BeehiveRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<SprayAreaRepository>(
    () => SprayAreaRepositoryImpl(getIt()),
  );
}

void _registerAuthNotifierDependencies() {
  getIt.registerSingleton<AuthStateNotifier>(
    AuthStateNotifier(),
  );
}

Future<void> _registerServicesDependencies() async {
  getIt.registerLazySingleton(() => SupabaseService());
  final firebaseMessage = FirebaseMessaging.instance;
  getIt.registerLazySingleton(() => firebaseMessage);
  getIt.registerLazySingleton<AbstractFirebaseMessagingService>(
    () => FirebaseMessagingService(),
  );
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => LocationService());
}
