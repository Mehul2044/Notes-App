import 'package:flutter/foundation.dart';

class Note with ChangeNotifier {
  final String noteId;
  final DateTime creationTime;
  String? title;
  String? body;

  Note(
      {required this.creationTime,
      this.title,
      this.body,
      required this.noteId});

  Future<void> updateNote(String? title, String? body) async {
    if (title != null) this.title = title;
    if (body != null) this.body = body;
    notifyListeners();
  }
}
