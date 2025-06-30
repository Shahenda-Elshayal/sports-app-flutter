import 'package:sports_app/data/models/teams_model.dart';

abstract class GetTeamsState {}

class GetTeamsInitial extends GetTeamsState {}

class GetTeamsLoading extends GetTeamsState {}

class GetTeamsSuccess extends GetTeamsState {
  final List<TeamModel> teams;

  GetTeamsSuccess(this.teams);
}

class GetTeamsError extends GetTeamsState {
  final String message;

  GetTeamsError(this.message);
}
