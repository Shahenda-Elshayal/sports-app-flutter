part of 'get_leagues_cubit.dart';

sealed class GetLeaguesState extends Equatable {
  const GetLeaguesState();

  @override
  List<Object> get props => [];
}

final class GetLeaguesInitial extends GetLeaguesState {}

final class GetLeaguesLoading extends GetLeaguesState {}

final class GetLeaguesSuccess extends GetLeaguesState {
  final List<LeagueModel> leagues;

  const GetLeaguesSuccess(this.leagues);

  @override
  List<Object> get props => [leagues];
}

final class GetLeaguesError extends GetLeaguesState {
  final String message;

  const GetLeaguesError(this.message);

  @override
  List<Object> get props => [message];
}
