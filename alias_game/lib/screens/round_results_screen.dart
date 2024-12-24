import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:alias_game/providers/game_provider.dart';
import 'package:alias_game/screens/start_round_screen.dart';


class RoundResultScreen extends StatelessWidget {
  const RoundResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameDataProvider = Provider.of<GameDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Конец раунда'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(children: [
            Text("Результат раунда: ${gameDataProvider.current_points} очков", 
            textAlign: TextAlign.center, 
            style: const TextStyle(fontSize: 25)),

            ElevatedButton(
              onPressed: (){
                gameDataProvider.endRound();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const StartRoundScreen()),
              );
              }, 
              child: const Text("Закончить"))
          ])
        ),
        )
    );
  }
}