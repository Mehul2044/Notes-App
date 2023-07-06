import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/screens/sign_in_screen.dart';
import '/screens/notes_overview_screen.dart';
import '/screens/splash_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  Widget alertDialog() {
    return const AlertDialog(
      title: Text("Error Occurred"),
      content: Text(
          "Make sure you are connected to a active Internet connection and try again!"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (ConnectionState.waiting == snapshot.connectionState) {
          return const SplashScreen();
        } else if (snapshot.hasData) {
          return FutureBuilder(
            future: null,
            builder: (context, data) {
              return const NotesOverViewScreen();
            },
          );
        } else {
          return const SignInScreen();
        }
      },
    );
  }
}
