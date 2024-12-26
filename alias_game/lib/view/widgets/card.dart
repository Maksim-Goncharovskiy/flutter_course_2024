import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alias_game/view_model/game_provider.dart';

class WordsCard extends StatefulWidget {
  const WordsCard({super.key});

  @override
  _WordsCardState createState() => _WordsCardState();
}

class _WordsCardState extends State<WordsCard> {
  int currentPoints = 0;

  List<Widget> makeCard({required GameDataProvider provider}){
    List<Widget> items = [];
    for (var word in provider.roundWords){
      items.add(
        CheckboxListTile(
          title: Text(word),
          value: provider.isMarked[word], 
          onChanged: (value) {
            provider.changeWordState(word: word, value: value);
            setState(() {
              currentPoints = provider.points;
            });
          })
      );
    }
    items.add(
      Text("Угадано слов: $currentPoints")
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