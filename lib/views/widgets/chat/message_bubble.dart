import 'package:flutter/material.dart';

class MessageBbuble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String receiverId;
  const MessageBbuble(
    this.message,
    this.isMe, {
    super.key,
    required this.receiverId,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: isMe
                  ? const Radius.circular(12.0)
                  : const Radius.circular(20.0),
              topRight: isMe
                  ? const Radius.circular(20.0)
                  : const Radius.circular(12),
              bottomLeft:
                  isMe ? const Radius.circular(20) : const Radius.circular(0),
              bottomRight:
                  isMe ? const Radius.circular(0) : const Radius.circular(20.0),
            ),
            color: Colors.teal.withOpacity(0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
              if (isMe) // Faqat foydalanuvchi o'zining yuborgan xabarida ko'rsatish
                Text(
                  'To: $receiverId',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
