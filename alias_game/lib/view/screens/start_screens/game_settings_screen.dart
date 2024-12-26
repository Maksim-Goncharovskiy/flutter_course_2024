import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:alias_game/providers/game_provider.dart';
import 'package:alias_game/screens/start_screens/team_editing_screen.dart';
import 'package:alias_game/screens/round_screens/start_round_screen.dart';
import 'package:alias_game/screens/start_screens/home_screen.dart';


class GameSettingsScreen extends StatelessWidget {
  const GameSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройка игры'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Выберите количество раундов:', style: TextStyle(fontSize: 20)),

              const SizedBox(height: 16),

              DropdownButton<int>(
                value: gameProvider.remainingRounds,
                onChanged: (int? newValue) {
                  if (newValue != null) {
                    gameProvider.setNumRounds(newValue);
                  }
                },
                items: List.generate(10, (index) => DropdownMenuItem(value: index + 1, child: Text('${index + 1}'))),
              )
            ],
          ),

          const SizedBox(height: 16),

          const Text("Добавляйте команды при помощи кнопки +", style: TextStyle(fontSize: 17.5)),

          const SizedBox(height: 16),

          Expanded(
            child: ListView.builder(
              itemCount: gameProvider.teams.length,
              itemBuilder: (context, index) {
                final team = gameProvider.teams[index];
                return ListTile(
                  title: Text(team.name),
                  onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TeamEditingScreen(team: team, index: index),
                  ),
                );
              },
            );}),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            FloatingActionButton(
            onPressed: () {
              gameProvider.addTeam(name: "Team ${gameProvider.teams.length + 1}");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TeamEditingScreen(team: gameProvider.teams.last, index: gameProvider.teams.length - 1), //Добавление новой заметки
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
            ElevatedButton(
            onPressed: (){
              if (gameProvider.teams.length > 0){
                gameProvider.makeQueue();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StartRoundScreen()));
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Количество команд должно быть отличным от нуля"),
                  showCloseIcon: true,
                  duration: Duration(seconds: 5),),
                );
              }
            }, 
            child: const Text("Начать", style: TextStyle(color: Colors.green, fontSize: 20))),
          
          ElevatedButton(
            onPressed: (){
              gameProvider.closeGame();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: const Text("Выйти из игры", style: TextStyle(color: Colors.red, fontSize: 20),)),
          ],)

        ],)

      )
      
    );
      
      
  }
}