import 'package:app_abelhas/core/di/service_locator.dart';
import 'package:app_abelhas/presentation/pages/home/home_page.dart';
import 'package:app_abelhas/presentation/pages/login/login_page.dart';
import 'package:app_abelhas/presentation/pages/signup/signup_page.dart';
import 'package:app_abelhas/presentation/pages/settings/settings_page.dart';
import 'package:app_abelhas/presentation/pages/splash/splash_page.dart';
import 'package:app_abelhas/presentation/providers/register_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => RegisterProvider(authRepository: getIt()),
        child: const SignUpPage(),
      ),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashPage(),
    ),
  ],
);
