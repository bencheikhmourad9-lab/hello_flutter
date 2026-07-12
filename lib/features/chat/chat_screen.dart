import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // متغيرات المحادثة التي قمنا بنقلها من الكود الضخم
  Map<String, dynamic>? _activeChatCase;
  final TextEditingController _chatMessageController = TextEditingController();
  final List<Map<String, dynamic>> _chatMessages = [];

  @override
  void dispose() {
    _chatMessageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("المحادثة")),
      body: Center(
        child: Text("عدد الرسائل: ${_chatMessages.length}"),
      ),
    );
  }
}