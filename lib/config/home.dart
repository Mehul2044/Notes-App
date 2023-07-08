import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers_helpers/note_provider.dart';

import '/screens/sign_in_screen.dart';
import '/screens/notes_overview_screen.dart';
import '/screens/splash_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  Future<void> loadData(NoteProvider noteProvider) async {
    await noteProvider.fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FutureBuilder(
            future: loadData(Provider.of<NoteProvider>(context, listen: false)),
            builder: (context, data) {
              if (data.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              }
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
