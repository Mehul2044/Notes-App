import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers_helpers/note_provider.dart';
import '/providers_helpers/sign_in_provider.dart';

import '/screens/notes_details_screen.dart';

import '/widgets/note_widget.dart';
import '/widgets/popup_menu_widget.dart';

class NotesOverViewScreen extends StatelessWidget {
  const NotesOverViewScreen({super.key});

  void _addNoteHandler(NoteProvider notesProvider, BuildContext context) async {
    final navigator = Navigator.of(context);
    await notesProvider.addNote();
    navigator.push(MaterialPageRoute(
      builder: (context) => const NotesDetailScreen(),
      settings: RouteSettings(arguments: notesProvider.list.last),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        actions: const [
          PopupMenuWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNoteHandler(
            Provider.of<NoteProvider>(context, listen: false), context),
        child: const Icon(Icons.add),
      ),
      body: Consumer<SignInProvider>(
        builder: (context, signInProvider, _) {
          return Consumer<NoteProvider>(builder: (context, notesProvider, _) {
            if (signInProvider.isLoading || notesProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (notesProvider.list.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("No Notes to Display"),
                      TextButton.icon(
                        onPressed: () =>
                            _addNoteHandler(notesProvider, context),
                        icon: const Icon(Icons.add),
                        label: const Text("Add a Note"),
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
          });
        },
      ),
    );
  }
}
