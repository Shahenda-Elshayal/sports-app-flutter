import 'package:dio/dio.dart';
import '../models/countries_model.dart';

class CountryRepo {
  final Dio dio = Dio();

  Future<List<CountryResponseModel>?> getCountries() async {
    try {
      final response = await dio.get(
        'https://apiv2.allsportsapi.com/football/?met=Countries&APIkey=44df4f65429caedb9fa0fbde49c2217da189e7f2f06594a2b007df43d815e47e',
      );

      if (response.statusCode == 200 && response.data['success'] == 1) {
        final List data = response.data['result'] ?? [];

        List<CountryResponseModel> countries =
            data.map((json) => CountryResponseModel.fromJson(json)).toList();

        return countries;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
