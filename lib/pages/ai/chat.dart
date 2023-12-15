/*
 * 聊天页面 
 * @Author: lilonglong
 * @Date: 2023-12-14 23:03:52
 * @Last Modified by: lilonglong
 * @Last Modified time: 2023-12-15 14:50:21
 */
import 'package:flutter/material.dart';
import 'package:mytoolbox/pages/ai/models/chat_model.dart';
import 'package:provider/provider.dart';
import './conversation_list.dart';
import './chat_input.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => ChatModel())],
        builder: (context, child) {
          return _buildChat(context);
        });
  }

  Widget _buildChat(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: ConversationList(),
        ),
        ChatInput(),
      ],
    );
  }
}
