import 'package:book_and_play_flutter/managers/push_notification_manager.dart';
import 'package:book_and_play_flutter/screens/expense_screen.dart';
import 'package:book_and_play_flutter/screens/home_screen.dart';
import 'package:book_and_play_flutter/screens/username_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:book_and_play_flutter/screens/welcome_screen.dart';
import 'package:book_and_play_flutter/screens/login_screen.dart';
import 'package:book_and_play_flutter/screens/registration_screen.dart';
import 'package:book_and_play_flutter/screens/chat_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  new PushNotificationsManager().init();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        UsernameScreen.id: (content) => UsernameScreen(),
        ExpenseScreen.id: (context) => ExpenseScreen(),
        HomeScreen.id: (content) => HomeScreen(),
      },
    );
  }
}
