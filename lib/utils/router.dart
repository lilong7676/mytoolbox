import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mytoolbox/models/app.dart';
import 'package:go_router/go_router.dart';
import 'package:mytoolbox/pages/home_page.dart';
import 'package:mytoolbox/pages/login.dart';
import 'package:mytoolbox/pages/ai/ai.dart';
import 'package:mytoolbox/pages/ai/detail.dart';
import 'package:mytoolbox/pages/paster/paster.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return MaterialApp.router(
          routerConfig: homeRouter,
        );
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
      return '/home';
    }
    return null;
  },
);

/// 这里定制 home 页面的路由，支持路由嵌套跳转
/// 参考 https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
final GoRouter homeRouter = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/ai',
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
          builder: (BuildContext context, GoRouterState state,
              StatefulNavigationShell navigationShell) {
            return HomePage(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(routes: [
              GoRoute(
                path: '/ai',
                builder: (BuildContext context, GoRouterState state) =>
                    const Ai(),
                // 可以在这里配置子路由
                routes: [
                  GoRoute(
                    path: 'detail',
                    builder: (BuildContext context, GoRouterState state) =>
                        const Detail(),
                  )
                ],
              )
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: '/paster',
                builder: (BuildContext context, GoRouterState state) =>
                    const Paster(),
                // 可以在这里配置子路由
                routes: [
                  GoRoute(
                    path: 'detail',
                    builder: (BuildContext context, GoRouterState state) =>
                        const Detail(),
                  )
                ],
              )
            ])
          ]),
    ]);
