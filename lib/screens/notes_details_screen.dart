import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/providers_helpers/note_provider.dart';
import 'package:provider/provider.dart';

import '/models/notes_model.dart';

class NotesDetailScreen extends StatelessWidget {
  const NotesDetailScreen({super.key});

  String formatDateTime(DateTime dateTime) {
    String formattedDate = DateFormat('d MMMM, y').format(dateTime);
    String formattedTime = DateFormat('h:mm a').format(dateTime);
    return "Created on $formattedDate at $formattedTime";
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);
    final Note obj = ModalRoute.of(context)!.settings.arguments as Note;
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
          noteProvider.deleteNote(obj.noteId);
        },
        style: IconButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
        icon: const Icon(Icons.delete, size: 35),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            obj.title == null
                ? Text(
                    "Add Title",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                  )
                : Text(
                    obj.title!,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
            Text(formatDateTime(obj.creationTime),
                style: Theme.of(context).textTheme.labelSmall),
            const SizedBox(height: 30),
            if (obj.body != null) Text(obj.body!),
          ],
        ),
      ),
    );
  }
}
