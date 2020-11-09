import 'package:book_and_play_flutter/components/str_button.dart';
import 'package:book_and_play_flutter/constants.dart';
import 'package:book_and_play_flutter/streams/message_stream.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = 'chat_room';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String message;
  String _username;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
      await _firestore
          .collection('users')
          .where('email', isEqualTo: loggedInUser.email)
          .get()
          .then((value) => value.docs.isEmpty
              ? _username = 'Unknown User'
              : _username = value.docs.single.get('username'));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kTextIconsColor,
          size: 30,
        ),
        leading: null,
        title: Text(
          'Chat',
          style: TextStyle(
            letterSpacing: 2,
            color: kPrimaryTextColor,
            fontSize: 30,
            fontFamily: 'League Gothic',
          ),
        ),
        backgroundColor: kDarkPrimaryColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(
              fireStoreInstance: _firestore,
            ),
            Container(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: messageTextController,
                      style: TextStyle(color: Colors.black),
                      onChanged: (value) {
                        message = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Type you message here...',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: STRCTAButton(
                        onPress: () {
                          messageTextController.clear();
                          _firestore.collection('messages').add({
                            'text': message,
                            'sender': loggedInUser.email,
                            'dateTime': DateTime.now(),
                            'username': _username,
                          });
                        },
                        buttonLabel: 'Send',
                        color: kAccentColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
