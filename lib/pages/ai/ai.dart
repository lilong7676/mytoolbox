/*
 * AI 首页
 * @Author: lilonglong
 * @Date: 2023-12-14 23:54:31
 * @Last Modified by: lilonglong
 * @Last Modified time: 2023-12-14 16:26:10
 */
import 'package:flutter/material.dart';
import 'package:mytoolbox/pages/ai/chat.dart';
import 'package:mytoolbox/pages/ai/chat_session_history.dart';

class Ai extends StatefulWidget {
  const Ai({Key? key}) : super(key: key);

  @override
  AiState createState() => AiState();
}

class AiState extends State<Ai> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Chat(),
        ChatSessionHistory(),
      ],
    );
  }
}
