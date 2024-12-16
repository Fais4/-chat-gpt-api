import 'package:camp_day9_chat_gpt/pages/gpt.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatUser me = ChatUser(id: "1");
  ChatUser bot = ChatUser(id: "2");

  List<ChatMessage> messagesList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DashChat(
          messageOptions: MessageOptions(
              currentUserContainerColor: Colors.green,
              containerColor: Colors.grey.shade300),
          currentUser: me,
          onSend: (newMessage) async {
            messagesList.insert(0, newMessage);
            setState(() {});

            String content = await Gpt().getData(newMessage.text);

            ChatMessage botMessage = ChatMessage(
              user: bot,
              createdAt: DateTime.now(),
              text: content,
            );
            messagesList.insert(0, botMessage);

            setState(() {});
          },
          messages: messagesList),
      backgroundColor: Colors.blueGrey.shade500,
    );
  }
}
