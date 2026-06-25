import 'package:auth/src/composition/router/router.dart';
import 'package:auth/src/features/login/presentation/bloc/login_bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

final List<GoRoute> authRoutes = [
  GoRoute(
    path: AuthRoutesPaths.login,
    builder: (context, state) => BlocProvider(
      create: (context) => GetIt.I<LoginBloc>(),
      child: Container(),
    ),
  ),
];
