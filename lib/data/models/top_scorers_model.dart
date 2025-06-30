class TopScorerModel {
  final String playerPlace;
  final String playerName;
  final int playerKey;
  final String teamName;
  final String teamKey;
  final String goals;
  final String? assists;
  final String penaltyGoals;

  TopScorerModel({
    required this.playerPlace,
    required this.playerName,
    required this.playerKey,
    required this.teamName,
    required this.teamKey,
    required this.goals,
    this.assists,
    required this.penaltyGoals,
  });

  factory TopScorerModel.fromJson(Map<String, dynamic> json) {
    return TopScorerModel(
      playerPlace: json['player_place'].toString(),
      playerName: json['player_name'].toString(),
      playerKey: int.parse(json['player_key'].toString()),
      teamName: json['team_name'].toString(),
      teamKey: json['team_key'].toString(),
      goals: json['goals'].toString(),
      assists: json['assists']?.toString(),
      penaltyGoals: json['penalty_goals'].toString(),
    );
  }
}
