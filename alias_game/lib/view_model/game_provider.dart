import 'dart:collection';

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:alias_game/models/team.dart';
import 'package:alias_game/models/team_model.dart';

import 'package:alias_game/models/round_model.dart';


class GameDataProvider extends ChangeNotifier {
  static const int wordsCardCount = 10;

  List<String> vocab;
  
  int remainingRounds = 1;

  final TeamModel _teamModel = TeamModel();
  List<Team> get teams => _teamModel.teams;

  final RoundModel _roundModel = RoundModel();

  Queue<int> currentQueue = Queue<int>();

  GameDataProvider({required this.vocab});

  int get teamIdx => _roundModel.teamIdx;
  String get teamName => _teamModel.teams[_roundModel.teamIdx].name;
  int get points => _roundModel.points;
  List<String> get roundWords => _roundModel.roundWords;
  Map<String, bool> get isMarked => _roundModel.isMarked;

  // Изменение количества раундов на странице настройки игры
  void setNumRounds(int newCount){
    remainingRounds = newCount;
    notifyListeners();
  }

  void addTeam({required String name}){
    _teamModel.addTeam(name: name);
    notifyListeners();
  }

  void removeTeam({required int idx}){
    _teamModel.removeTeam(idx: idx);
    notifyListeners();
  }

  void editTeam({required int idx, required String newName}){
    _teamModel.editTeam(idx: idx, newName: newName);
    notifyListeners();
  }

  // Добавление очков команде по завершении раунда
  void plusPoints({required int idx, required int points}){
    _teamModel.plusPoints(idx: idx, points: points);
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
    final random = Random();
    final Set<String> subset = {};

    while (subset.length < wordsCardCount){
      subset.add(vocab[random.nextInt(vocab.length)]);
    }

    List<String> roundWords = subset.toList();

    Map<String, bool> isMarked = {};

    for (var word in roundWords) {
      isMarked[word] = false;
    }

    _roundModel.startRound(teamIdx: teamIdx, words: roundWords, isMarked: isMarked);

    notifyListeners();
  }


  // Изменение статуса слова в процессе раунда: отгадано/не отгадано
  void changeWordState({required String word, required bool? value}){
    _roundModel.changeWordState(word: word, value: value);
    
    notifyListeners();
  }

  void cancelRound(){
    _teamModel.plusPoints(idx: _roundModel.teamIdx, points: _roundModel.points);
    currentQueue.removeFirst();
    _roundModel.cancelRound();

    notifyListeners();
  }

  void closeGame(){
    _teamModel.emptyScores();

    remainingRounds = 1;

    _roundModel.cancelRound();

    currentQueue = Queue<int>();

    notifyListeners();
  }
}