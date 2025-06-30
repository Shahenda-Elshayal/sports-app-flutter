// import 'package:dio/dio.dart';
// import 'package:sports_app/data/models/leagues_model.dart';

// class LeaguesRepo {
//   final Dio dio = Dio();

//   Future<List<LeagueModel>> getLeagues() async {
//     final url =
//         'https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=d894e8dcfb22b30a3d1faa90480e8f0029a4bdd16cc6c3d2e9de0dd1b87c258e';
//     final response = await dio.get(url);

//     if (response.statusCode == 200 && response.data['success'] == 1) {
//       final results = response.data['result'] as List;
//       return results.map((json) => LeagueModel.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load leagues');
//     }
//   }
// }
