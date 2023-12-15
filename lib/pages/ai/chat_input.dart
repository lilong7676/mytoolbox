import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mytoolbox/pages/ai/models/chat_model.dart';
import 'package:provider/provider.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({Key? key}) : super(key: key);

  @override
  ChatInputState createState() => ChatInputState();
}

class ChatInputState extends State<ChatInput> {
  late final _focusNode = FocusNode(onKey: handleKeyPress);
  final TextEditingController _chatEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150,
        child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                maxLines: 5,
                focusNode: _focusNode,
                controller: _chatEditingController,
                decoration: const InputDecoration.collapsed(
                    hintText: '请输入聊天内容，回车发送, Shift + 回车换行'),
              ),
            )));
  }

  KeyEventResult handleKeyPress(FocusNode focusNode, RawKeyEvent event) {
    // handles submit on enter
    if (event.isKeyPressed(LogicalKeyboardKey.enter) && !event.isShiftPressed) {
      send(_chatEditingController.text);
      // handled means that the event will not propagate
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  void send(String text) {
    // ignore: avoid_print
    print(text);

    context.read<ChatModel>().addConversationItem();

    // bring focus back to the input field
    Future.delayed(Duration.zero, () {
      _focusNode.requestFocus();
      _chatEditingController.clear();
    });
  }
}
