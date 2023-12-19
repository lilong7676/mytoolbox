/*
 * 全局快捷键管理
 * @Author: lilonglong
 * @Date: 2023-12-19 23:15:54
 * @Last Modified by: lilonglong
 * @Last Modified time: 2023-12-19 17:52:17
 */
import 'package:flutter/services.dart';
import 'package:super_hot_key/super_hot_key.dart';
import 'package:window_manager/window_manager.dart';

class HotkeyManager {
  static final hotkeys = <HotKey>[];

  static void init() async {
    final hotKey = await HotkeyManager.register(
      definition: HotKeyDefinition(
          key: PhysicalKeyboardKey.keyV, shift: true, alt: true),
      callback: () async {
        final visiable = await windowManager.isVisible();
        if (visiable) {
          await windowManager.hide();
        } else {
          await windowManager.show();
          await windowManager.focus();
        }
      },
    );
    if (hotKey != null) {
      hotkeys.add(hotKey);
    }
  }

  static Future<HotKey?> register(
      {required HotKeyDefinition definition,
      required void Function() callback}) async {
    final hotKey = await HotKey.create(
      definition: definition,
      callback: callback,
    );
    if (hotKey != null) {
      hotkeys.add(hotKey);
    }
    return hotKey;
  }

  static void dispose() {
    for (var hotKey in hotkeys) {
      hotKey.dispose();
    }
  }
}
