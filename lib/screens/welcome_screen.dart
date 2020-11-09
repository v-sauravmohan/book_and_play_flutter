import 'package:book_and_play_flutter/components/str_button.dart';
import 'package:book_and_play_flutter/constants.dart';
import 'package:book_and_play_flutter/screens/login_screen.dart';
import 'package:book_and_play_flutter/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  final _auth = FirebaseAuth.instance;
  final _storage = FlutterSecureStorage();
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
    isUserLoggedIn();
  }

  void isUserLoggedIn() async {
    try {
      setState(() {
        showSpinner = true;
      });
      final email = await _storage.read(key: 'email');
      final password = await _storage.read(key: 'password');
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        Navigator.pushReplacementNamed(context, HomeScreen.id);
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      showSpinner = false;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/STR_logo.png'),
                      height: 120.0,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'SWING THAT',
                        style: TextStyle(
                          color: kPrimaryTextColor,
                          fontFamily: 'League Gothic',
                          fontSize: 70.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'RACKET!',
                        style: TextStyle(
                          color: kPrimaryTextColor,
                          fontFamily: 'League Gothic',
                          fontSize: 70.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              STRCTAButton(
                color: kPrimaryColor,
                buttonLabel: 'Log In',
                onPress: () {
                  //Go to Login screen.
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
              STRCTAButton(
                color: kDarkPrimaryColor,
                buttonLabel: 'Register',
                onPress: () {
                  //Go to registration screen.
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
