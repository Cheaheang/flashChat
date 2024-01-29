import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/firebase_options.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
      routes: {
       LoginScreen.id:(context) => LoginScreen(),
       RegistrationScreen.id:(context) => RegistrationScreen(),
       ChatScreen.id:(context) => ChatScreen()
      },
    );
  }
}
