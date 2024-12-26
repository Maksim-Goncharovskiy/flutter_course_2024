import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:alias_game/view_model/game_provider.dart';
import 'package:alias_game/view/screens/start_screens/home_screen.dart';


class GameResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Результаты'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: gameProvider.teams.length,
              itemBuilder: (context, index) {
              final team = gameProvider.teams[index];
              return ListTile(
                title: Text('${team.name} - ${team.score} очков', style: TextStyle(fontSize: 20)),
              );
            },
            ),
          ),
          ElevatedButton(
            onPressed: (){
              gameProvider.closeGame();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            }, 
            child: const Text("Завершить игру", style: TextStyle(color: Colors.red, fontSize: 20)))
        ],
      )
    );
  }
}
