import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:mytoolbox/models/app.dart';
import 'package:mytoolbox/common/theme.dart';
import 'utils/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> prefs) {
          AppModel appModel = AppModel();

          // 判断是否登录
          var isLogin = false;
          if (prefs.hasData) {
            var data = prefs.data;
            isLogin = data?.getBool('isLogin') ?? false;
            // 修改登录状态
            isLogin ? appModel.login() : appModel.logout();
          }

          // 使用 MultiProvider 包裹整个应用, 用于状态管理
          return MultiProvider(
            providers: [ChangeNotifierProvider(create: (_) => appModel)],
            child: MaterialApp.router(
                title: 'MyToolbox', theme: appTheme, routerConfig: router),
          );
        });
  }
}
