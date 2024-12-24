import 'package:flutter/material.dart';
import 'dart:math';

class GameDataProvider extends ChangeNotifier {
  static const int wordsCardCount = 10;

  List<String> vocab;

  List<String> currentRoundWords = [];
  Map<String, bool> currentIsMarked = {};
  int current_points = 0;

  GameDataProvider({required this.vocab});

  void startRound() {
    final random = Random();
    final Set<String> subset = {};

    while (subset.length < wordsCardCount){
      subset.add(vocab[random.nextInt(vocab.length)]);
    }
    currentRoundWords = subset.toList();

    for (var word in currentRoundWords) {
      currentIsMarked[word] = false;
    }

    notifyListeners();
  }

  void recalculatePoints(){
    current_points = currentIsMarked.values.where((item) => item).length;
  }

  void changeWordState({required String word, required bool? value}){
    currentIsMarked[word] = value ?? false;
    recalculatePoints();
    notifyListeners();
  }

  void endRound(){
    currentRoundWords = [];
    currentIsMarked = {};
    current_points = 0;
    notifyListeners();
  }
}