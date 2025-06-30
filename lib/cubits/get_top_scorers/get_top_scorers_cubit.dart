import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_app/cubits/get_top_scorers/get_top_scorers_state.dart';
import 'package:sports_app/data/repos/top_scorers_repo.dart';

class TopScorersCubit extends Cubit<TopScorersState> {
  final TopScorersRepo repo;

  TopScorersCubit(this.repo) : super(TopScorersInitial());

  Future<void> getTopScorers(String leagueId) async {
    emit(TopScorersLoading());
    try {
      final topScorers = await repo.getTopScorers(leagueId);

      if (topScorers == null) {
        emit(TopScorersError('No data found for top scorers.'));
      } else {
        emit(TopScorersSuccess(topScorers));
      }
    } catch (e) {
      emit(TopScorersError(e.toString()));
    }
  }
}
