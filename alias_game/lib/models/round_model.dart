import 'package:alias_game/models/round.dart';

class RoundModel {
  Round round = Round();

  int get points => round.points;

  int get teamIdx => round.teamIdx;

  List<String> get roundWords => List.unmodifiable(round.roundWords);

  Map<String, bool> get isMarked => Map.unmodifiable(round.isMarked);

  void startRound({required int teamIdx, required List<String> words, required Map<String, bool> isMarked}){
    round.teamIdx = teamIdx;
    round.roundWords = words;
    round.isMarked = isMarked;
  }

  void changeWordState({required String word, required bool? value}){
    round.isMarked[word] = value ?? false;
    recalculatePoints();
  }

  void recalculatePoints(){
    round.points = round.isMarked.values.where((item) => item).length;
  }

  void cancelRound(){
    round.roundWords = [];
    round.isMarked = {};
    round.points = 0;
  }
}