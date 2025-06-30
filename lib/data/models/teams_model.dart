class TeamModel {
  final String teamKey;
  final String teamName;
  final String teamLogo;

  TeamModel({
    required this.teamKey,
    required this.teamName,
    required this.teamLogo,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      teamKey: json['team_key'].toString(),
      teamName: json['team_name'] ?? '',
      teamLogo: json['team_logo'] ?? '',
    );
  }
}
