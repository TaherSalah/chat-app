import 'package:chat_app/screens/home.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/screens/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'Login': (context) => const LoginScreen(),
        'Register': (context) => RegisterScreen(),
        'Home': (context) => const HomeScreen(),
      },
      theme: ThemeData(
        useMaterial3: true,

      ),
      initialRoute: 'Login',
    );
  }
}
