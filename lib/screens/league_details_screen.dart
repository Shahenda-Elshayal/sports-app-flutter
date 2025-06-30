import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sports_app/cubits/get_top_scorers/get_top_scorers_cubit.dart';
import 'package:sports_app/cubits/get_top_scorers/get_top_scorers_state.dart';
import 'package:sports_app/screens/players_screen.dart';
import '../data/models/leagues_model.dart';
import '../data/repos/teams_repo.dart';
import '../data/repos/top_scorers_repo.dart';
import '../cubits/get_teams/get_teams_cubit.dart';
import '../cubits/get_teams/get_teams_state.dart';
import '../widgets/app_drawer.dart';

class LeagueDetailsScreen extends StatelessWidget {
  final LeagueModel league;
  final User user;

  const LeagueDetailsScreen({
    super.key,
    required this.league,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  GetTeamsCubit(TeamRepo())
                    ..getTeams(league.leagueKey.toString()),
        ),
        BlocProvider(
          create:
              (_) =>
                  TopScorersCubit(TopScorersRepo(Dio()))
                    ..getTopScorers(league.leagueKey.toString()),
        ),
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color(0xFF211C12),
          appBar: AppBar(
            backgroundColor: const Color(0xFF211C12),
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              league.leagueName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            bottom: const TabBar(
              indicatorColor: Color(0xFFF5C754),
              labelColor: Color(0xFFF5C754),
              unselectedLabelColor: Colors.white54,
              tabs: [Tab(text: 'Teams'), Tab(text: 'Top Scorers')],
            ),
          ),
          drawer: AppDrawer(
            user: user,
            onLogout: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
          body: TabBarView(
            children: [_TeamsTab(user: user), const _TopScorersTab()],
          ),
        ),
      ),
    );
  }
}

class _TeamsTab extends StatelessWidget {
  final User user;
  const _TeamsTab({required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<GetTeamsCubit, GetTeamsState>(
        builder: (context, state) {
          if (state is GetTeamsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFF5C754)),
            );
          } else if (state is GetTeamsSuccess) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 3 / 2,
              ),
              itemCount: state.teams.length,
              itemBuilder: (context, index) {
                final team = state.teams[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => PlayersScreen(team: team, user: user),
                      ),
                    );
                  },
                  child: Card(
                    color: const Color(0xFF2E2618),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          team.teamLogo.isNotEmpty
                              ? Image.network(
                                'https://cors-anywhere.herokuapp.com/${team.teamLogo}',
                                width: 60,
                                height: 60,
                                errorBuilder:
                                    (_, __, ___) => const Icon(
                                      Icons.shield,
                                      color: Colors.white,
                                      size: 60,
                                    ),
                              )
                              : const Icon(
                                Icons.shield,
                                color: Colors.white,
                                size: 60,
                              ),
                          const SizedBox(height: 8),
                          Text(
                            team.teamName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is GetTeamsError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.green),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class _TopScorersTab extends StatelessWidget {
  const _TopScorersTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<TopScorersCubit, TopScorersState>(
        builder: (context, state) {
          if (state is TopScorersLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFF5C754)),
            );
          } else if (state is TopScorersSuccess) {
            final topScorers = state.topScorers;

            if (topScorers.isEmpty) {
              return const Center(
                child: Text(
                  'No top scorers data found.',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              );
            }

            return ListView.separated(
              itemCount: topScorers.length,
              separatorBuilder: (_, __) => const Divider(color: Colors.white24),
              itemBuilder: (context, index) {
                final scorer = topScorers[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFFF5C754),
                    child: Text(
                      scorer.playerPlace,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    scorer.playerName,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    '${scorer.goals} goals',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                );
              },
            );
          } else if (state is TopScorersError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
