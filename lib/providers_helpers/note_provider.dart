import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/providers_helpers/encrypt_helper.dart';

import '/models/notes_model.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _list = [];

  List<Note> get list {
    return [..._list];
  }

  void addNote() async {
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection(userId);
    final creationTime = DateTime.now();
    final result = await userCollection.add({
      "creationTime": creationTime.toIso8601String(),
    });
    _list.add(Note(noteId: result.id, creationTime: creationTime));
    notifyListeners();
  }

  void deleteNote(String id) {
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection(userId);
    userCollection.doc(id).delete();
    _list.removeWhere((element) => element.noteId == id);
    notifyListeners();
  }

  Future<void> fetchNotes() async {
    _list.clear();
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection(userId);
    final QuerySnapshot snapshot = await userCollection.get();
    final List<Note> notes = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Note(
        noteId: doc.id,
        title:
            data['title'] == null ? null : EncryptHelper.decrypt(data['title']),
        body: data['body'] == null ? null : EncryptHelper.decrypt(data['body']),
        creationTime: DateTime.parse(data["creationTime"]),
      );
    }).toList();
    _list = notes;
  }
}
