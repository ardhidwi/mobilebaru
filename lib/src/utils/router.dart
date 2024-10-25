import 'package:car_workshop_flutter/src/feature/admin/bookings/view/admin_dashboard.dart';
import 'package:car_workshop_flutter/src/feature/admin/bookings/view/widgets/add_new_booking_widget.dart';
import 'package:car_workshop_flutter/src/feature/authentication/view/admin_login_screen.dart';
import 'package:car_workshop_flutter/src/feature/authentication/view/login_screen.dart';
import 'package:car_workshop_flutter/src/feature/authentication/view/register_mechanic_screen.dart';
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
        return LoginScreen();
      },
    ),
    GoRoute(
      path: AdminLoginScreen.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return AdminLoginScreen();
      },
    ),
    GoRoute(
      path: RegisterMechanicScreen.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return RegisterMechanicScreen();
      },
    ),
    GoRoute(
      path: AdminDashboardScreen.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const AdminDashboardScreen();
      },
    ),
    GoRoute(
      path: AddNewBookingWidget.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return AddNewBookingWidget();
      },
    ),
  ],
);
