/*
 * 会话历史列表
 * @Author: lilonglong
 * @Date: 2023-12-14 23:09:11
 * @Last Modified by: lilonglong
 * @Last Modified time: 2023-12-14 16:39:46
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatSessionHistory extends StatefulWidget {
  const ChatSessionHistory({Key? key}) : super(key: key);

  @override
  ChatSessionHistoryState createState() => ChatSessionHistoryState();
}

class ChatSessionHistoryState extends State<ChatSessionHistory> {
  final List<String> entries = <String>['A', 'B', 'C'];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(entries[index]),
            onTap: () {
              GoRouter.of(context).go('/ai/detail');
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
