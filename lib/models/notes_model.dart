import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '/providers_helpers/encrypt_helper.dart';

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

  void updateNote(String? title, String? body) {
    if (title != null) this.title = title;
    if (body != null) this.body = body;
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection(userId);
    final Map<String, dynamic> data = {};
    if (title != null) {
      data['title'] = title.isEmpty ? null : EncryptHelper.encrypt(title);
    }
    if (body != null) {
      data['body'] = body.isEmpty ? null : EncryptHelper.encrypt(body);
    }
    userCollection.doc(noteId).update(data);
    notifyListeners();
  }
}
