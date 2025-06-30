class PlayerModel {
  final int playerKey;
  final String playerName;
  final String? playerNumber;
  final String? playerType;
  final String? playerAge;
  final String? playerGoals;
  final String? playerMatchPlayed;
  final String? playerImage;
  final String? teamName;
  final String? teamKey;

  PlayerModel({
    required this.playerKey,
    required this.playerName,
    this.playerNumber,
    this.playerType,
    this.playerAge,
    this.playerGoals,
    this.playerMatchPlayed,
    this.playerImage,
    this.teamName,
    this.teamKey,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      playerKey: int.parse(json['player_key'].toString()),
      playerName: json['player_name'].toString(),
      playerNumber: json['player_number']?.toString(),
      playerType: json['player_type']?.toString(),
      playerAge: json['player_age']?.toString(),
      playerGoals: json['player_goals']?.toString(),
      playerMatchPlayed: json['player_match_played']?.toString(),
      playerImage: json['player_image']?.toString(),
      teamName: json['team_name']?.toString(),
      teamKey: json['team_key']?.toString(),
    );
  }

  get playerCountry => null;

  get playerYellowCards => null;

  get playerRedCards => null;

  get playerAssists => null;
}
