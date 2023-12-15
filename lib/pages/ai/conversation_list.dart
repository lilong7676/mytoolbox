/*
 * 聊天记录列表
 * @Author: lilonglong
 * @Date: 2023-12-15 23:02:59
 * @Last Modified by: lilonglong
 * @Last Modified time: 2023-12-15 14:37:46
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mytoolbox/pages/ai/models/chat_model.dart';

class ConversationList extends StatefulWidget {
  const ConversationList({Key? key}) : super(key: key);

  @override
  ConversationListState createState() => ConversationListState();
}

class ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatModel>(builder: (context, model, child) {
      var conversationList = model.conversationList;
      return ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: conversationList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(conversationList[index].content),
            onTap: () {},
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      );
    });
  }
}
