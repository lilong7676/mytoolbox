import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mytoolbox/models/app.dart';
import 'package:go_router/go_router.dart';
import 'package:mytoolbox/pages/home_page.dart';
import 'package:mytoolbox/pages/login.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const Login();
      },
    ),
  ],
  redirect: (BuildContext context, GoRouterState state) async {
    AppModel appModel = context.read<AppModel>();
    final bool loggedIn = appModel.isLogin;
    final bool loggingIn = state.matchedLocation == '/login';
    if (!loggedIn) {
      return '/login';
    }
    if (loggingIn) {
      return '/';
    }
    return null;
  },
);
