/*
 * 聊天记录item
 * @Author: lilonglong
 * @Date: 2023-12-15 23:39:53
 * @Last Modified by: lilonglong
 * @Last Modified time: 2023-12-15 10:58:45
 */

import 'package:mytoolbox/models/user.dart';

/// 聊天记录类型
enum ConversationItemType { text }

/// 聊天记录方向
enum ConversationItemDirection { send, receive }

/// 聊天记录项
class ConversationItem {
  final type = ConversationItemType.text;
  final ConversationItemDirection direction;
  final User fromUser;
  final String content;
  final DateTime serverTime;
  final DateTime receiveTime;

  ConversationItem(
      {required this.direction,
      required this.fromUser,
      required this.content,
      required this.serverTime,
      required this.receiveTime});

  static ConversationItem mock() {
    return ConversationItem(
        direction: ConversationItemDirection.send,
        fromUser: User.mock(),
        content: 'hello',
        serverTime: DateTime.now(),
        receiveTime: DateTime.now());
  }
}
