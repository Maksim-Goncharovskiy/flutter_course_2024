import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:alias_game/providers/game_provider.dart';
import 'package:alias_game/screens/round_screens/start_round_screen.dart';
import 'package:alias_game/screens/last_screen/game_results.dart';
import 'package:alias_game/screens/start_screens/home_screen.dart';


class RoundResultScreen extends StatelessWidget {
  const RoundResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Конец раунда'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(children: [
            Text("Команда: ${gameProvider.teams[gameProvider.currentRound.teamIdx].name}"),
            Text("Результат раунда: ${gameProvider.currentRound.currentPoints} очков", 
            textAlign: TextAlign.center, 
            style: const TextStyle(fontSize: 25)),

            // Конец раунда:
            // 1. Добавление очков команде и очистка данных раунда.
            // 2. Удаление команды из очереди и переход на следущую страницу:
            //    2.1. Если очередь пустая и количество оставшихся раундов = 0, то -> страница результатов
            //    2.2. Если очередь пустая, но раунды еще остались, создаем новую очередь и -> страница начала раунда.
            //    2.3. Если очередь не пустая, то просто продолжаем текущий круг -> страница начала раунда.
            
            ElevatedButton(
              onPressed: (){

                int teamIdx = gameProvider.currentRound.teamIdx;
                int points = gameProvider.currentRound.currentPoints;
                gameProvider.teams[teamIdx].score += points;

                gameProvider.endRound();

                gameProvider.currentQueue.removeFirst();
                print(gameProvider.currentQueue);

                if (gameProvider.currentQueue.isEmpty){

                  gameProvider.remainingRounds -= 1;

                  if (gameProvider.remainingRounds == 0){
                    // переход к странице результатов
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => GameResultsPage()),
                    );
                  }
                  else {
                    gameProvider.makeQueue();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const StartRoundScreen()),
                    );
                  }
                }
                else{
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const StartRoundScreen()),
                  );
                }
              }, 
              child: const Text("Далее", style: TextStyle(color: Colors.green),)),

              ElevatedButton(
                onPressed: (){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()));
                  gameProvider.closeGame();
                }, 
                child: const Text("Завершить игру", style: TextStyle(color: Colors.red)))
          ])
        ),
        )
    );
  }
}