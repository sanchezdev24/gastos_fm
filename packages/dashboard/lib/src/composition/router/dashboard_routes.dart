import 'package:core/core.dart';
import 'package:dashboard/dashboard.dart';
import 'package:dashboard/src/features/home/presentation/screens/home_screen.dart';

final List<GoRoute> dashboardRoutes = [
  GoRoute(
    path: DashboardRoutesPaths.home,
    builder: (context, state) => const HomeScreen(),
  ),
];
