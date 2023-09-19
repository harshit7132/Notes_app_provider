import 'package:flutter/material.dart';
import 'package:notes_app_provider_new/Database/Db%20Helper.dart';
import 'package:notes_app_provider_new/Database/Note%20Model.dart';

class NoteProvider extends ChangeNotifier {
  List<noteModel> arrNotes = [];
  DB_helper db = DB_helper.db;

  //by default notes when app opens
  fetchInitialNotes() async {
    arrNotes = await db.fetchAllNotes();
    notifyListeners();
  }

  // get notes when add
  List<noteModel> getNotes() {
    fetchInitialNotes();
    return arrNotes;
  }

  //add notes
  addNotes(noteModel newNote) async {
    var check = await db.addNotes(newNote);
    if (check) {
      arrNotes = await db.fetchAllNotes();
      notifyListeners();
    }
  }

  //update notes
  updateNotes(noteModel note_id) async {
    var check = await db.updateNotes(note_id);
    if (check) {
      arrNotes = await db.fetchAllNotes();
      notifyListeners();
    }
  }

  //delete notes
  deleteNotes(noteModel note_id) async {
    var check = await db.deleteNotes(note_id as int);
    if (check) {
      arrNotes = await db.fetchAllNotes();
      notifyListeners();
    }
  }
}
