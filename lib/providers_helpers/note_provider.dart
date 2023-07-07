import 'package:flutter/foundation.dart';

import '/models/notes_model.dart';

class NoteProvider with ChangeNotifier {
  final List<Note> _list = [];

  List<Note> get list {
    return [..._list];
  }

  Future<void> addNote() async {
    _list.add(
        Note(noteId: DateTime.now().toString(), creationTime: DateTime.now()));
    notifyListeners();
  }

  Future<void> deleteNote(String id) async {
    _list.removeWhere((element) => element.noteId == id);
    notifyListeners();
  }
}
