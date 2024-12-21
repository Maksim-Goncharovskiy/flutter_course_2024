import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note_model.dart';
import '../providers/notes_provider.dart';

class NotePage extends StatefulWidget {
  final Note note;
  final int index;

  const NotePage({super.key, required this.note, required this.index});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  TextEditingController? _titleController;
  TextEditingController? _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);

    _descriptionController = TextEditingController(text: widget.note.description);
  }


  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesSetProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Редактирование заметки"),
      ),
      body: Center(
        child: 
          Column(children: [
            SizedBox(
              width: 250, 
              height: 100,
              child: TextFormField(
                controller: _titleController,
                maxLines: null,
                decoration: const InputDecoration(labelText: "Заголовок")
              )),

            const SizedBox(height: 32),

            SizedBox(
              width: 250, 
              height: 100,
              child:
                TextFormField(
                  controller: _descriptionController,
                  maxLines: null,
                  decoration: const InputDecoration(labelText: "Описание"),
                )
            ),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_titleController!.text != ""){
                        notesProvider.editItem(widget.index, _titleController!.text, _descriptionController!.text);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Сохранено!"),
                          showCloseIcon: true,
                          duration: Duration(seconds: 3),
                        ));
                      } else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Ошибка сохранения: заголовок не может быть пустым!"),
                          showCloseIcon: true,
                          duration: Duration(seconds: 5),
                        ));
                      }
                      
                    }, 
                    child: const Icon(Icons.save)
                  ),

                  const SizedBox(width: 16),

                  ElevatedButton(
                    onPressed: (){
                      notesProvider.delItem(widget.index);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Удалено!"), 
                        showCloseIcon: true, 
                        duration: Duration(seconds: 3)));
                    }, 
                    child: const Icon(Icons.delete))
                  ])
            ),
        ]),
      )
    );
  }
}