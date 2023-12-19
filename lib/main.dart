import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:mytoolbox/utils/hotkey_manager.dart';
import 'package:mytoolbox/models/app.dart';
import 'package:mytoolbox/common/theme.dart';
import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  // 热更新时，先 dispose，再 init
  HotkeyManager.dispose();
  HotkeyManager.init();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

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
