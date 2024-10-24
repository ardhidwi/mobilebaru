import 'package:car_workshop_flutter/src/feature/authentication/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:car_workshop_flutter/src/global/views/splash.dart';
import 'package:car_workshop_flutter/src/feature/home/view/home.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: SplashView.routePath,
  routes: [
    GoRoute(
      path: SplashView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashView();
      },
    ),
    GoRoute(
      path: HomeView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeView();
      },
    ),
    GoRoute(
      path: LoginScreen.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
  ],
);
