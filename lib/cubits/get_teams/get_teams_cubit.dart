// import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:sports_app/data/models/teams_model.dart';
// import 'package:sports_app/data/repos/teams_repo.dart';
// import 'get_teams_state.dart';

// class GetTeamsCubit extends Cubit<GetTeamsState> {
//   final TeamRepo teamRepo;

//   GetTeamsCubit(this.teamRepo) : super(GetTeamsInitial());

//   bool? get isLoaded => null;

//   void getTeams(String leagueId) async {
//     emit(GetTeamsLoading());

//     final teams = await teamRepo.getTeamsByLeagueId(leagueId);

//     if (teams != null) {
//       emit(GetTeamsSuccess(teams));
//     } else {
//       emit(GetTeamsError('Failed to load teams'));
//     }
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_app/data/repos/teams_repo.dart';
import 'get_teams_state.dart';

class GetTeamsCubit extends Cubit<GetTeamsState> {
  final TeamRepo teamRepo;
  bool _isLoaded = false;

  GetTeamsCubit(this.teamRepo) : super(GetTeamsInitial());

  bool get isLoaded => _isLoaded;

  void getTeams(String leagueId) async {
    if (_isLoaded) return;

    emit(GetTeamsLoading());

    final teams = await teamRepo.getTeamsByLeagueId(leagueId);

    if (teams != null) {
      _isLoaded = true;
      emit(GetTeamsSuccess(teams));
    } else {
      emit(GetTeamsError('Failed to load teams'));
    }
  }
}
