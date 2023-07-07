import 'package:flutter/material.dart';
import 'package:notes_app/screens/notes_details_screen.dart';
import 'package:provider/provider.dart';

import '/models/notes_model.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Note>(
      builder: (context, noteObj, _) {
        final hasTitle = noteObj.title != null;
        final hasBody = noteObj.body != null;
        return GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const NotesDetailScreen(),
            settings: RouteSettings(arguments: noteObj),
          )),
          child: Container(
            padding: const EdgeInsets.all(30),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            constraints: const BoxConstraints(maxHeight: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            child: Column(
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
                      ),
                      if (hasBody) const SizedBox(height: 30),
                    ],
                  ),
                if (hasBody)
                  Text(
                    noteObj.body!,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
