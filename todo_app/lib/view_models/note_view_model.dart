import 'package:flutter/material.dart';
import 'package:todo_app/database_service/note_service.dart';

import '../models/note.dart';

class NotesProvider with ChangeNotifier {
  List<Note> noteList = [];

  Future<List<Note>> fetchAllNotes() async {
    return DatabaseHelper.instance.getNotes();
  }

  add(Note note) async {
    DatabaseHelper.instance.add(note);
    notifyListeners();
  }

  delete(int id) async {
    DatabaseHelper.instance.remove(id);
    notifyListeners();
  }
}
