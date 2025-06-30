import 'package:dio/dio.dart';
import 'package:sports_app/data/models/top_scorers_model.dart';

class TopScorersRepo {
  final Dio dio;

  TopScorersRepo(this.dio);

  Future<List<TopScorerModel>?> getTopScorers(String leagueId) async {
    try {
      final response = await dio.get(
        'https://apiv2.allsportsapi.com/football/',
        queryParameters: {
          'met': 'Topscorers',
          'leagueId': leagueId,
          'APIkey':
              '44df4f65429caedb9fa0fbde49c2217da189e7f2f06594a2b007df43d815e47e',
        },
      );

      if (response.statusCode == 200 && response.data['success'] == 1) {
        final result = response.data['result'];
        if (result == null) return [];
        final List<dynamic> data = result;
        return data.map((json) => TopScorerModel.fromJson(json)).toList();
      } else {
        return null;
      }
    } catch (e) {
      print('Error in getTopScorers: $e');
      return null;
    }
  }
}
