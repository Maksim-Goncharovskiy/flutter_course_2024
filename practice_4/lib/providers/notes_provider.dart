import 'package:flutter/material.dart';
import '../models/note_model.dart';

class NotesSetProvider extends ChangeNotifier {
  List<Note> notes = [];


  void addItem(Note item){
    notes.add(item);
    notifyListeners();
  }

  void delItem(int idx){
    notes.removeAt(idx);
    notifyListeners();
  }

  void editItem(int idx, String title, String description){
    notes[idx].title = title;
    notes[idx].description = description;
    notifyListeners();
  }
}