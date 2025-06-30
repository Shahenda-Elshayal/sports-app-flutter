import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_app/cubits/get_leagues/get_leagues_cubit.dart';
import 'package:sports_app/data/google_sign_in_service.dart';
import 'package:sports_app/screens/league_details_screen.dart';
import 'package:sports_app/screens/login_screen.dart';
import '../widgets/app_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LeaguesScreen extends StatelessWidget {
  final String countryName;
  final User user;

  const LeaguesScreen({
    super.key,
    required this.countryName,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetLeaguesCubit()..getLeaguesByCountry(countryName),
      child: Scaffold(
        backgroundColor: const Color(0xFF211C12),
        appBar: AppBar(
          backgroundColor: const Color(0xFF211C12),
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            'Leagues',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        drawer: AppDrawer(
          user: user,
          onLogout: () async {
            await GoogleSignInService.logout();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false,
            );
          },
        ),
        body: BlocBuilder<GetLeaguesCubit, GetLeaguesState>(
          builder: (context, state) {
            if (state is GetLeaguesLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFFF5C754)),
              );
            } else if (state is GetLeaguesError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else if (state is GetLeaguesSuccess) {
              final leagues = state.leagues;

              return ListView.builder(
                itemCount: leagues.length,
                itemBuilder: (context, index) {
                  final league = leagues[index];
                  return ListTile(
                    leading:
                        league.leagueLogo != null
                            ? Image.network(
                              'https://cors-anywhere.herokuapp.com/${league.leagueLogo!}',
                              width: 40,
                              height: 40,
                              errorBuilder:
                                  (context, error, stackTrace) => const Icon(
                                    Icons.sports,
                                    color: Colors.white,
                                  ),
                            )
                            : const Icon(Icons.sports, color: Colors.white),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => LeagueDetailsScreen(
                                league: league,
                                user: user,
                              ),
                        ),
                      );
                    },

                    title: Text(
                      league.leagueName,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
