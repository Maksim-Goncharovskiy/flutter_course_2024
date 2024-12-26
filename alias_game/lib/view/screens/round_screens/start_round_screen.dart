import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'round_screen.dart';
import 'package:alias_game/view_model/game_provider.dart';


class StartRoundScreen extends StatelessWidget {


  const StartRoundScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final gameProvider = Provider.of<GameDataProvider>(context);
    int teamIdx = gameProvider.currentQueue.first;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Начало раунда"),
      ),
      body: Container(
        child: Center(
          child: Column(children: [
            const SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Команда: ", style: TextStyle(fontSize: 20),),
                Text("${gameProvider.teams[teamIdx].name}", style: TextStyle(fontSize: 20, color: Colors.green),),
              ],),
            const SizedBox(height: 50),
            SizedBox(
              width: 250,
              height: 150,
              child: ElevatedButton(
                onPressed: () {
                  gameProvider.startRound(teamIdx: teamIdx);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => RoundScreen()));
                  }, 
                child: const Text("Начать", style: TextStyle(fontSize: 40),)),
            )
          ],)
        ),
      ),
    );
  }
}