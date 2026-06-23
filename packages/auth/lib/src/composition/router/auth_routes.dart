import 'package:auth/src/composition/router/router.dart';
import 'package:auth/src/features/login/presentation/bloc/login_bloc.dart';
import 'package:auth/src/features/login/presentation/screens/create_account_screen.dart';
import 'package:auth/src/features/login/presentation/screens/login_screen.dart';
import 'package:auth/src/features/login/presentation/screens/onboarding_card_screen.dart';
import 'package:auth/src/features/login/presentation/screens/password_creens.dart';
import 'package:auth/src/features/login/presentation/screens/password_recovery_code_screen.dart';
import 'package:auth/src/features/login/presentation/screens/password_recovery_screen.dart';
import 'package:auth/src/features/login/presentation/screens/start_screen.dart';
import 'package:core/core.dart';

final List<GoRoute> authRoutes = [
  GoRoute(
    path: AuthRoutesPaths.start,
    builder: (context, state) => StartScreen(),
  ),
  GoRoute(
    path: AuthRoutesPaths.createAccount,
    builder: (context, state) => CreateAccountScreen(),
  ),
  GoRoute(
    path: AuthRoutesPaths.login,
    builder: (context, state) => BlocProvider(
      create: (context) => GetIt.I<LoginBloc>(),
      child: const LoginScreen(),
    ),
  ),
  GoRoute(
    path: AuthRoutesPaths.password,
    builder: (context, state) => WrongPasswordScreen(),
  ),
  GoRoute(
    path: AuthRoutesPaths.passwordRecovery,
    builder: (context, state) => PasswordRecoveryScreen(),
  ),
  GoRoute(
    path: AuthRoutesPaths.passwordRecoveryCode,
    builder: (context, state) => PasswordRecoveryCodeScreen(),
  ),
  GoRoute(
    path: AuthRoutesPaths.onboarding,
    builder: (context, state) => HelloCardScreen(),
  ),
];
