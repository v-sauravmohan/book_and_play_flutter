import 'package:book_and_play_flutter/components/str_button.dart';
import 'package:book_and_play_flutter/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class UsernameScreen extends StatefulWidget {
  static String id = 'username_screen';
  @override
  _UsernameScreenState createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String username;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/STR_logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.name,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  username = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter username',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              STRCTAButton(
                color: kDarkPrimaryColor,
                buttonLabel: 'Confirm',
                onPress: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  _firestore.collection('users').add({
                    'email': loggedInUser.email,
                    'username': username,
                  });
                  try {
                    Navigator.pushReplacementNamed(context, HomeScreen.id);
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
