import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/sign_in_provider.dart';

import '/widgets/popup_menu_widget.dart';

class NotesOverViewScreen extends StatelessWidget {
  const NotesOverViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        actions: const [
          PopupMenuWidget(),
        ],
      ),
      body: Consumer<SignInProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Column();
          }
        },
      ),
    );
  }
}
