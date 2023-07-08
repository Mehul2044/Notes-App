import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '/models/notes_model.dart';

import '/providers_helpers/note_provider.dart';

import '/widgets/input_area_widget.dart';

class NotesDetailScreen extends StatefulWidget {
  const NotesDetailScreen({super.key});

  @override
  State<NotesDetailScreen> createState() => _NotesDetailScreenState();
}

class _NotesDetailScreenState extends State<NotesDetailScreen> {
  bool _showFAB = true;

  String formatDateTime(DateTime dateTime) {
    String formattedDate = DateFormat('d MMMM, y').format(dateTime);
    String formattedTime = DateFormat('h:mm a').format(dateTime);
    return "Created on $formattedDate at $formattedTime";
  }

  Future<bool> _confirmDeleteHandler(BuildContext context) async {
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
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);
    final Note obj = ModalRoute.of(context)!.settings.arguments as Note;
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: _showFAB
          ? IconButton(
              onPressed: () async {
                final navigator = Navigator.of(context);
                bool isDelete = await _confirmDeleteHandler(context);
                if (isDelete) {
                  navigator.pop();
                  noteProvider.deleteNote(obj.noteId);
                }
              },
              style: IconButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.delete, size: 35),
            )
          : null,
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            bool showFABTemp = !(notification.metrics.extentBefore > 0) &&
                !(notification.metrics.extentInside <
                    notification.metrics.maxScrollExtent);
            if (showFABTemp != _showFAB) {
              setState(() => _showFAB = showFABTemp);
            }
          }
          return true;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputArea(
                  isTitle: true,
                  noteObj: obj,
                  textEditingController: TextEditingController(text: obj.title),
                ),
                Text(
                  formatDateTime(obj.creationTime),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 20),
                InputArea(
                  isTitle: false,
                  noteObj: obj,
                  textEditingController: TextEditingController(text: obj.body),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
