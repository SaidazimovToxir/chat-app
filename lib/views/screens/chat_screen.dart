import 'package:chat_app/views/widgets/chat/messages.dart';
import 'package:chat_app/views/widgets/chat/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class ChatScreen extends StatelessWidget {
  final String chatRoomId;
  final String receiverId;

  const ChatScreen({
    super.key,
    required this.chatRoomId,
    required this.receiverId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat app", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        
      ),
      body: Column(
        children: [
          Expanded(
            child: Messages(chatRoomId: chatRoomId),
          ),
          NewMessage(chatRoomId: chatRoomId, receiverId: receiverId),
        ],
      ),
    );
  }
}
