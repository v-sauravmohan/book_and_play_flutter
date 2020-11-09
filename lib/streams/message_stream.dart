import 'package:book_and_play_flutter/components/str_messages_bubble.dart';
import 'package:book_and_play_flutter/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageStream extends StatelessWidget {
  final FirebaseFirestore fireStoreInstance;
  MessageStream({@required this.fireStoreInstance});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: fireStoreInstance.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlue,
            ),
          );
        }
        final messages = snapshot.data.docs.reversed;
        List<STRMessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message.get('text');
          final sender = message.get('sender');
          final username = message.get('username');
          final dateTime = message.get('dateTime');
          final messageBubble = STRMessageBubble(
            sender: sender,
            text: messageText,
            isMe: loggedInUser.email == sender ? true : false,
            username: username,
            dateTime: dateTime,
          );
          messageBubbles.add(messageBubble);
        }
        messageBubbles.sort((a, b) => b.dateTime.compareTo(a.dateTime));
        return Flexible(
          child: ListView(
            reverse: true,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
