/* 
  Главная страница приложения, отображающая список всех заметок(их заголовки)
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note_model.dart';
import '../providers/notes_provider.dart';
import 'notepage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesSetProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Заметки'),
      ),
      body: ListView.builder(
        itemCount: notesProvider.notes.length,
        itemBuilder: (context, index) {
          final note = notesProvider.notes[index];
          return ListTile(
            title: Text(note.title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotePage(note: note, index: index),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          notesProvider.addItem(Note(title: "My Note", description: "-"));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotePage(note: notesProvider.notes.last, index: notesProvider.notes.length - 1), //Добавление новой заметки
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}