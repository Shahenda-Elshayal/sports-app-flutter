import 'package:equatable/equatable.dart';
import 'package:sports_app/data/models/top_scorers_model.dart';

abstract class TopScorersState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TopScorersInitial extends TopScorersState {}

class TopScorersLoading extends TopScorersState {}

class TopScorersSuccess extends TopScorersState {
  final List<TopScorerModel> topScorers;

  TopScorersSuccess(this.topScorers);

  @override
  List<Object?> get props => [topScorers];
}

class TopScorersError extends TopScorersState {
  final String message;

  TopScorersError(this.message);

  @override
  List<Object?> get props => [message];
}
