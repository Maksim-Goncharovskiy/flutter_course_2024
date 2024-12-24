class Round {
  int teamIdx = -1;

  List<String> currentRoundWords = [];
  Map<String, bool> currentIsMarked = {};
  int currentPoints = 0;

  void recalculatePoints(){
    currentPoints = currentIsMarked.values.where((item) => item).length;
  }

  void emptyRoundData(){
    currentRoundWords = [];
    currentIsMarked = {};
    currentPoints = 0;
  }
}