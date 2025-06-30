import 'package:dio/dio.dart';
import 'package:sports_app/data/models/teams_model.dart';

class TeamRepo {
  final Dio dio = Dio();

  Future<List<TeamModel>?> getTeamsByLeagueId(String leagueId) async {
    try {
      final response = await dio.get(
        'https://apiv2.allsportsapi.com/football/',
        queryParameters: {
          'met': 'Teams',
          'leagueId': leagueId,
          'APIkey':
              '44df4f65429caedb9fa0fbde49c2217da189e7f2f06594a2b007df43d815e47e',
        },
      );

      if (response.statusCode == 200 && response.data['success'] == 1) {
        final List data = response.data['result'];
        return data.map((teamJson) => TeamModel.fromJson(teamJson)).toList();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
