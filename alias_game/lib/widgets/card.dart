import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alias_game/providers/game_provider.dart';

class WordsCard extends StatefulWidget {
  const WordsCard({super.key});

  @override
  _WordsCardState createState() => _WordsCardState();
}

class _WordsCardState extends State<WordsCard> {

  List<Widget> makeCard({required GameDataProvider provider}){
    List<Widget> items = [];
    for (var word in provider.currentRound.currentRoundWords){
      items.add(
        CheckboxListTile(
          title: Text(word),
          value: provider.currentRound.currentIsMarked[word], 
          onChanged: (value) {
            provider.changeWordState(word: word, value: value);
          })
      );
    }
    items.add(
      Text("Угадано слов: ${provider.currentRound.currentPoints}")
    );
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final gameDataProvider = Provider.of<GameDataProvider>(context);
    return Column(
      children: makeCard(provider: gameDataProvider),
    );
  }
}