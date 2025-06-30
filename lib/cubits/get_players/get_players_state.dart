part of 'get_players_cubit.dart';

abstract class GetPlayersState extends Equatable {
  const GetPlayersState();

  @override
  List<Object> get props => [];
}

class GetPlayersInitial extends GetPlayersState {}

class GetPlayersLoading extends GetPlayersState {}

class GetPlayersSuccess extends GetPlayersState {
  final List<PlayerModel> players;

  const GetPlayersSuccess(this.players);

  @override
  List<Object> get props => [players];
}

class GetPlayersFailure extends GetPlayersState {
  final String message;

  const GetPlayersFailure(this.message);

  @override
  List<Object> get props => [message];
}
