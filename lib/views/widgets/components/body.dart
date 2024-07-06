import 'package:chat_app/utils/style.dart';
import 'package:chat_app/views/screens/chat_screen.dart';
import 'package:chat_app/views/widgets/components/chat_card.dart';
import 'package:chat_app/views/widgets/components/filled_outline_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          color: AppStyle.kPrimaryColor,
          child: Row(
            children: [
              FillOutlineButton(press: () {}, text: "Recent Message"),
              const SizedBox(width: 16),
              FillOutlineButton(
                press: () {},
                text: "Active",
                isFilled: false,
              ),
            ],
          ),
        ),
        // Expanded(
        //   child: ListView.builder(
        //     itemCount: chatsData.length,
        //     itemBuilder: (context, index) => ChatCard(
        //       chat: chatsData[index],
        //       press: () => Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => const MessagesScreen(),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),

        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
              final users = snapshot.data!.docs;
              return ListView.separated(
                itemCount: users.length,
                separatorBuilder: (context, index) => const Gap(20.0),
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ChatCard(
                    onPressed: () {
                      final currentUserId =
                          FirebaseAuth.instance.currentUser!.uid;
                      final chatRoomId = getChatRoomId(currentUserId, user.id);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatScreen(
                            chatRoomId: chatRoomId,
                            receiverId: user.id,
                            name: user['username'],
                          ),
                        ),
                      );
                    },
                    name: user['username'],
                    lastMessage: user['email'],
                    lastActive: "lastActive",
                  );
                  // return ListTile(
                  //   onTap: () {
                  //     final currentUserId =
                  //         FirebaseAuth.instance.currentUser!.uid;
                  //     final chatRoomId = getChatRoomId(currentUserId, user.id);

                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (_) => ChatScreen(
                  //           chatRoomId: chatRoomId,
                  //           receiverId: user.id,
                  //         ),
                  //       ),
                  //     );
                  //   },
                  //   leading: const CircleAvatar(),
                  //   title: Text(user['username']),
                  //   subtitle: Text(user['email']),
                  // );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  String getChatRoomId(String userId1, String userId2) {
    if (userId1.hashCode <= userId2.hashCode) {
      return '$userId1-$userId2';
    } else {
      return '$userId2-$userId1';
    }
  }
}
