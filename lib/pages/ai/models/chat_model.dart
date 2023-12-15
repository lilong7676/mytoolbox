import 'package:flutter/foundation.dart';
import './conversation_item.dart';

class ChatModel extends ChangeNotifier {
  final List<ConversationItem> conversationList = [];

  void addConversationItem() {
    conversationList.add(ConversationItem.mock());
    notifyListeners();
  }
}
