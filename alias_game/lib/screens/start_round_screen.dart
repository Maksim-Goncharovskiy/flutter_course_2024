import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'round_screen.dart';
import 'package:alias_game/providers/game_provider.dart';


class StartRoundScreen extends StatelessWidget {
  const StartRoundScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final gameDataProvider = Provider.of<GameDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Начало раунда", style: TextStyle(color: Color.fromARGB(255, 173, 163, 228))),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: SizedBox(
            width: 250,
            height: 150,
            child: ElevatedButton(
            onPressed: () {
              gameDataProvider.startRound();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => RoundScreen()));
            }, 
            child: const Text("Начать раунд", style: TextStyle(fontSize: 25),)),
          )
        ),
      ),
    );
  }
}