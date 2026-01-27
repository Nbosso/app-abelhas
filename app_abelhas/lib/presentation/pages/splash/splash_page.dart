import 'dart:async';
import 'dart:developer';

import 'package:app_abelhas/core/auth/auth_state_notifier.dart';
import 'package:app_abelhas/core/di/service_locator.dart';
import 'package:app_abelhas/core/services/firebase_messaging_service.dart';
import 'package:app_abelhas/core/services/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final supabaseService = getIt.get<SupabaseService>();
  final authStateNotifier = getIt.get<AuthStateNotifier>();
  final firebaseMessagingService = getIt.get<AbstractFirebaseMessagingService>();
  // final localSecureStorage = getIt.get<FirebaseMessagingService>();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    _checkLogin();
  }

  Future<void> _checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));

    final isLogged = await supabaseService.isLogged();
    await firebaseMessagingService.initialize();
    if (!mounted) return;

    if (isLogged) {
      context.go('/home');
    } else {
      context.go('/login');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _animation,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 200,
              ),
              const SizedBox(height: 16),
              Text(
                'BeeAlert',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
