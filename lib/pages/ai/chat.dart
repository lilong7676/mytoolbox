/*
 * 聊天页面 
 * @Author: lilonglong
 * @Date: 2023-12-14 23:03:52
 * @Last Modified by: lilonglong
 * @Last Modified time: 2023-12-14 15:14:07
 */
import 'package:flutter/material.dart';

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
    return const Expanded(
      child: Text("聊天页面"),
    );
  }
}
