import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:alias_game/models/team.dart';
import 'package:alias_game/providers/game_provider.dart';

class TeamEditingScreen extends StatefulWidget {
  final Team team;
  final int index;

  const TeamEditingScreen({super.key, required this.team, required this.index});

  @override
  State<TeamEditingScreen> createState() => _NotePageState();
}

class _NotePageState extends State<TeamEditingScreen> {
  TextEditingController? _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.team.name);

  }


  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Страница команды"),
      ),
      body: Center(
        child: 
          Column(children: [
            SizedBox(
              width: 250, 
              height: 100,
              child: TextFormField(
                controller: _nameController,
                maxLines: null,
                decoration: const InputDecoration(labelText: "Наименование команды")
              )),

            const SizedBox(height: 32),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_nameController!.text != ""){
                        gameProvider.editTeam(idx: widget.index, name: _nameController!.text);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Сохранено!"),
                          showCloseIcon: true,
                          duration: Duration(seconds: 3),
                        ));
                      } else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Ошибка сохранения: имя команды не может быть пустым!"),
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
                      gameProvider.delTeam(widget.index);
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