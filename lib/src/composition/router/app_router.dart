import 'package:core/core.dart';
import 'package:dashboard/dashboard.dart';
import 'package:ecommerce_fm/src/composition/di/feature_modules.dart';
import 'package:ecommerce_fm/src/composition/router/app_router_paths.dart';
import 'package:ecommerce_fm/src/composition/router/app_shell.dart';
import 'package:ecommerce_fm/src/featues/splash/bloc/splash_bloc.dart';
import 'package:ecommerce_fm/src/featues/splash/screens/error_screen.dart';
import 'package:ecommerce_fm/src/featues/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  final GetIt it;
  AppRouter(this.it);

  late final GoRouter router = GoRouter(
    initialLocation: AppRouterPaths.splash,
    routes: [
      // ── Splash (fuera del shell) ──────────────────────────────
      GoRoute(
        path: AppRouterPaths.splash,
        builder: (context, state) => BlocProvider(
          create: (_) => it<SplashBloc>(),
          child: const SplashScreen(),
        ),
      ),

      // ── Login (fuera del shell) ───────────────────────────────
      ...featureModules.expand((f) => f.routes()),

      // ── Shell con Bottom Nav ──────────────────────────────────
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          // Tab 0 - Dashboard
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: DashboardRoutesPaths.home,
                builder: (context, state) => Container(),
              ),
            ],
          ),

          // Tab 1 -
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/catalogue',
                builder: (context, state) => Center(child: Text('Catalogos')),
              ),
            ],
          ),

          // Tab 2 -
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/purchases',
                builder: (context, state) => Center(child: Text('Mis Compras')),
              ),
            ],
          ),

          // Tab 3 -
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => Center(child: Text('Profile')),
              ),
            ],
          ),
        ],
      ),
    ],
    observers: [it<RouteObserver<ModalRoute<void>>>()],
    errorBuilder: (context, state) =>
        ErrorScreen(errorMsg: state.error!.message),
    redirect: _redirect,
  );

  String? _redirect(BuildContext context, GoRouterState state) {
    return null;
  }
}
