import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class STRMessageBubble extends StatelessWidget {
  final String text;
  final String sender;
  final String username;
  final bool isMe;
  final Timestamp dateTime;
  STRMessageBubble(
      {this.text, this.sender, this.username, this.isMe, this.dateTime});

  _formatTime<String>() {
    var data =
        DateTime.fromMillisecondsSinceEpoch(dateTime.millisecondsSinceEpoch);
    var time = '${data.hour}:${data.minute}';
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              Text(
                _formatTime(),
                style: TextStyle(
                  fontSize: 10.0,
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                isMe ? 'You' : username,
                style: TextStyle(
                  fontSize: 10.0,
                ),
              ),
            ],
          ),
          Material(
            borderRadius:
                isMe ? kMeMessageBubbleBorder : kDefaultMessageBubbleBorder,
            elevation: 5.0,
            color: isMe ? kAccentColor : kPrimaryColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: Text(
                '$text',
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
