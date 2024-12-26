import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:alias_game/view/screens/start_screens/home_screen.dart';
import 'package:alias_game/utils/vocabulary_loader.dart';
import 'package:alias_game/view_model/game_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  loadVocabulary().then((value) {
    runApp(
      ChangeNotifierProvider(
        create: (context) => GameDataProvider(vocab: value),
        child: const AliasGame()
      )
    );
  },);
}


class AliasGame extends StatelessWidget {
  const AliasGame({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Alias Game",
      home: HomeScreen()
    );
  }
}