import 'package:alias_game/models/team.dart';

class TeamModel {
  final List<Team> _teams = [];

  List<Team> get teams => List.unmodifiable(_teams);

  void addTeam({required String name}){
    _teams.add(Team(name: name, score: 0));
  }

  void removeTeam({required int idx}){
    _teams.removeAt(idx);
  }

  void editTeam({required int idx, required String newName}){
    _teams[idx].name = newName;
  }

  void emptyScores(){
    for (int i = 0; i < _teams.length; i++){
      _teams[i].score = 0;
    }
  }

  void plusPoints({required int idx, required int points}){
    _teams[idx].score += points;
  }
}