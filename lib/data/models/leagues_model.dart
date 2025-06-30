class LeagueModel {
  final int leagueKey;
  final String leagueName;
  final int countryKey;
  final String countryName;
  final String? leagueLogo;

  LeagueModel({
    required this.leagueKey,
    required this.leagueName,
    required this.countryKey,
    required this.countryName,
    required this.leagueLogo,
  });

  factory LeagueModel.fromJson(Map<String, dynamic> json) {
    return LeagueModel(
      leagueKey: json['league_key'],
      leagueName: json['league_name'],
      countryKey: json['country_key'],
      countryName: json['country_name'],
      leagueLogo: json['league_logo'],
    );
  }
}
