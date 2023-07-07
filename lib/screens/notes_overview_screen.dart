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
    final notesProvider = Provider.of<NoteProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        actions: const [
          PopupMenuWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => notesProvider.addNote(),
        child: const Icon(Icons.add),
      ),
      body: Consumer<SignInProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (notesProvider.list.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("No Notes to Display"),
                    TextButton.icon(
                      onPressed: () => notesProvider.addNote(),
                      icon: const Icon(Icons.add),
                      label: const Text("Add a Note"),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: notesProvider.list[index],
                    child: const NoteWidget(),
                  );
                },
                itemCount: notesProvider.list.length);
          }
        },
      ),
    );
  }
}
