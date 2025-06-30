import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:sports_app/data/models/leagues_model.dart';

part 'get_leagues_state.dart';

class GetLeaguesCubit extends Cubit<GetLeaguesState> {
  GetLeaguesCubit() : super(GetLeaguesInitial());

  Future<void> getLeaguesByCountry(String countryName) async {
    emit(GetLeaguesLoading());

    try {
      final response = await Dio().get(
        'https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=44df4f65429caedb9fa0fbde49c2217da189e7f2f06594a2b007df43d815e47e',
      );

      if (response.statusCode == 200 && response.data['success'] == 1) {
        final List data = response.data['result'];
        final leagues = data.map((e) => LeagueModel.fromJson(e)).toList();

        final filteredLeagues =
            leagues
                .where(
                  (league) =>
                      league.countryName.toLowerCase() ==
                      countryName.toLowerCase(),
                )
                .toList();

        emit(GetLeaguesSuccess(filteredLeagues));
      } else {
        emit(const GetLeaguesError('Failed to load leagues'));
      }
    } catch (e) {
      emit(GetLeaguesError(e.toString()));
    }
  }
}
