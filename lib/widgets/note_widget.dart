import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/notes_model.dart';

import '/providers_helpers/note_provider.dart';

import '/screens/notes_details_screen.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key});

  Future<bool> _confirmDismissDelete(BuildContext context) async {
    late bool returnValue;
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Confirm Delete"),
              content: const Text("Are you sure you want to delete the note?"),
              actions: [
                TextButton(
                  onPressed: () {
                    returnValue = true;
                    Navigator.of(context).pop();
                  },
                  child: const Text("Yes, delete"),
                ),
                TextButton(
                    onPressed: () {
                      returnValue = false;
                      Navigator.of(context).pop();
                    },
                    child: const Text("No")),
              ],
            ));
    return returnValue;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Note>(
      builder: (context, noteObj, _) {
        final hasTitle = noteObj.title != null && noteObj.title != "";
        final hasBody = noteObj.body != null && noteObj.body != "";
        return GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const NotesDetailScreen(),
            settings: RouteSettings(arguments: noteObj),
          )),
          child: Dismissible(
            key: Key(noteObj.noteId),
            direction: DismissDirection.horizontal,
            confirmDismiss: (_) => _confirmDismissDelete(context),
            onDismissed: (_) =>
                Provider.of<NoteProvider>(context, listen: false)
                    .deleteNote(noteObj.noteId),
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 1,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
              child: !hasTitle && !hasBody
                  ? Center(
                      heightFactor: 1,
                      child: Text(
                        "EMPTY NOTE\nTap to Edit or Swipe to Discard",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (hasTitle)
                          Column(
                            children: [
                              Text(
                                noteObj.title!,
                                style: Theme.of(context).textTheme.titleLarge,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              if (hasBody) const SizedBox(height: 20),
                            ],
                          ),
                        if (hasBody)
                          Text(
                            noteObj.body!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 6,
                          ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
