import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sports_app/data/models/player_model.dart';
import 'package:sports_app/data/repos/player_repo.dart';

part 'get_players_state.dart';

class GetPlayersCubit extends Cubit<GetPlayersState> {
  final PlayerRepo playerRepo;
  bool _isLoaded = false;

  GetPlayersCubit(this.playerRepo) : super(GetPlayersInitial());

  bool get isLoaded => _isLoaded;

  Future<void> fetchPlayers(String teamId) async {
    if (_isLoaded) return;

    emit(GetPlayersLoading());

    final players = await playerRepo.getPlayersByTeamId(teamId);

    if (players != null) {
      _isLoaded = true;
      emit(GetPlayersSuccess(players));
    } else {
      emit(GetPlayersFailure("Failed to load players"));
    }
  }
}
