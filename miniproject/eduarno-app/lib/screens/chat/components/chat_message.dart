import 'package:flutter/material.dart';

enum ChatMessageType { text, image, document }
// enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
  final String text;
  final ChatMessageType messageType;
  final DateTime time;
  // final MessageStatus messageStatus;
  final bool isSender;

  ChatMessage(
    this.text,
    this.messageType,
    /* this.messageStatus*/ this.isSender,
    this.time,
  );
}

List demoChat = [
  ChatMessage(
      "Justo kasd no erat sed gubergren diam et rebum diam accusam, invidunt ut rebum eos lorem dolor, clita aliquyam sea.",
      ChatMessageType.text,
      false,
      DateTime.now()),
  ChatMessage("Hello how are you?", ChatMessageType.text, true, DateTime.now()),
  ChatMessage("", ChatMessageType.image, true, DateTime.now()),
  ChatMessage("", ChatMessageType.document, true, DateTime.now()),
];

class ChatMessageNotifier extends ChangeNotifier {
  static final ChatMessageNotifier _singleton = ChatMessageNotifier._internal();

  factory ChatMessageNotifier() {
    return _singleton;
  }

  ChatMessageNotifier._internal();

  bool _isActive = false;
  bool get isActive => _isActive;
  set isActive(bool value) {
    _isActive = value;
    notifyListeners();
  }
}
