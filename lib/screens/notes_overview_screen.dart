import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers_helpers/note_provider.dart';
import '/providers_helpers/sign_in_provider.dart';

import '/widgets/note_widget.dart';
import '/widgets/popup_menu_widget.dart';

class NotesOverViewScreen extends StatelessWidget {
  const NotesOverViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, notesProvider, _) => Scaffold(
        appBar: AppBar(
          title: const Text("Notes"),
          actions: const [
            PopupMenuWidget(),
          ],
        ),
        floatingActionButton: notesProvider.list.isEmpty
            ? null
            : FloatingActionButton(
                onPressed: notesProvider.isLoading
                    ? null
                    : () => notesProvider.addNote(),
                child: notesProvider.isLoading
                    ? const CircularProgressIndicator()
                    : const Icon(Icons.add),
              ),
        body: Consumer<SignInProvider>(
          builder: (context, signInProvider, _) {
            if (signInProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (notesProvider.list.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("No Notes to Display"),
                      TextButton.icon(
                        onPressed: notesProvider.isLoading
                            ? null
                            : () => notesProvider.addNote(),
                        icon: const Icon(Icons.add),
                        label: notesProvider.isLoading
                            ? const CircularProgressIndicator()
                            : const Text("Add a Note"),
                      ),
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: notesProvider.list[index],
                        child: const NoteWidget(),
                      );
                    },
                    itemCount: notesProvider.list.length);
              }
            }
          },
        ),
      ),
    );
  }
}
