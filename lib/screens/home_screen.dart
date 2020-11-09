import 'package:book_and_play_flutter/components/str_tile_button.dart';
import 'package:book_and_play_flutter/constants.dart';
import 'package:book_and_play_flutter/screens/chat_screen.dart';
import 'package:book_and_play_flutter/screens/expense_screen.dart';
import 'package:book_and_play_flutter/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  final _storage = FlutterSecureStorage();
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
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(
              'Are you sure?',
              style: TextStyle(color: kPrimaryTextColor),
            ),
            content: new Text(
              'Do you want to exit an App',
              style: TextStyle(color: kSecondaryTextColor),
            ),
            backgroundColor: Colors.white,
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text(
                  "NO",
                  style: TextStyle(color: kPrimaryTextColor),
                ),
              ),
              SizedBox(
                height: 30,
                width: 20,
              ),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text(
                  "YES",
                  style: TextStyle(color: kPrimaryTextColor),
                ),
              ),
              SizedBox(
                height: 30,
                width: 10,
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          leading: null,
          actions: [
            IconButton(
              icon: Icon(
                Icons.close,
                size: 30,
                color: kTextIconsColor,
              ),
              onPressed: () async {
                try {
                  _auth.signOut();
                  await _storage.deleteAll();
                  Navigator.popAndPushNamed(context, WelcomeScreen.id);
                } catch (e) {
                  print(e);
                }
              },
            ),
          ],
          title: Text(
            'HOME',
            style: TextStyle(
              letterSpacing: 2,
              color: kPrimaryTextColor,
              fontSize: 30,
              fontFamily: 'League Gothic',
            ),
          ),
          backgroundColor: kDarkPrimaryColor,
        ),
        body: ModalProgressHUD(
          inAsyncCall: _username == null ? true : false,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                            child: _username != null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.person_outline,
                                        color: kTextIconsColor,
                                        size: 70,
                                      ),
                                      Text(
                                        "Hi $_username",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: kPrimaryTextColor,
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                          ),
                        ),
                      ),
                      STRTileButton(
                        icon: Icons.book,
                        onPress: null,
                        label: 'Book a Game',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      STRTileButton(
                        icon: Icons.table_chart,
                        onPress: null,
                        label: 'Today\'s fixture',
                      ),
                      STRTileButton(
                        icon: Icons.chat,
                        onPress: () {
                          Navigator.pushNamed(context, ChatScreen.id);
                        },
                        label: 'Club Chat',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      STRTileButton(
                        icon: Icons.score,
                        onPress: () {
                          Navigator.pushNamed(context, ExpenseScreen.id);
                        },
                        label: 'Track exprenses',
                      ),
                      STRTileButton(
                        icon: Icons.help_outline,
                        onPress: null,
                        label: 'Help',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
