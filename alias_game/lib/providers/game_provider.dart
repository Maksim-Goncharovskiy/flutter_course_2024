import 'dart:collection';

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:alias_game/models/round.dart';
import 'package:alias_game/models/team.dart';


class GameDataProvider extends ChangeNotifier {
  static const int wordsCardCount = 10;

  List<String> vocab;
  
  int remainingRounds = 1;

  List<Team> teams = [];

  Round currentRound = Round();
  Queue<int> currentQueue = Queue<int>();



  GameDataProvider({required this.vocab});

  // Изменение количества раундов на странице настройки игры
  void changeCountRounds(int newCount){
    remainingRounds = newCount;
    notifyListeners();
  }

  void addTeam(Team team){
    teams.add(team);
    notifyListeners();
  }

  void delTeam(int idx){
    teams.removeAt(idx);
    notifyListeners();
  }

  void editTeam({required int idx, required String name}){
    teams[idx].name = name;
    notifyListeners();
  }

  // Добавление очков команде по завершении раунда
  void plusPoints(int idx, int points){
    teams[idx].score += points;
    notifyListeners();
  }

  // В начале каждого круга создаем очередь команд
  void makeQueue(){
    for (int i = 0; i < teams.length; i++){
      currentQueue.add(i);
    }
    notifyListeners();
  }


  void startRound({required int teamIdx}) {
    currentRound.teamIdx = teamIdx;

    final random = Random();
    final Set<String> subset = {};

    while (subset.length < wordsCardCount){
      subset.add(vocab[random.nextInt(vocab.length)]);
    }
    currentRound.currentRoundWords = subset.toList();

    for (var word in currentRound.currentRoundWords) {
      currentRound.currentIsMarked[word] = false;
    }

    notifyListeners();
  }


  // Изменение статуса слова в процессе раунда: отгадано/не отгадано
  void changeWordState({required String word, required bool? value}){
    currentRound.currentIsMarked[word] = value ?? false;
    currentRound.recalculatePoints();
    notifyListeners();
  }

  void endRound(){
    currentRound.emptyRoundData();
    notifyListeners();
  }

  void closeGame(){
    remainingRounds = 1;

    currentRound.emptyRoundData();
    currentQueue = Queue<int>();
    notifyListeners();
  }
}