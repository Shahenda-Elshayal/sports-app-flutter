import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_plus/share_plus.dart'; // ✅ أضف هذه السطر
import 'package:sports_app/cubits/get_players/get_players_cubit.dart';
import '../widgets/app_drawer.dart';
import 'package:sports_app/data/models/player_model.dart';
import 'package:sports_app/data/repos/player_repo.dart';

class PlayersScreen extends StatelessWidget {
  final dynamic team;
  final User user;

  const PlayersScreen({super.key, required this.team, required this.user});

  void showPlayerDetails(BuildContext context, PlayerModel player) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2A2519),
          title: Text(
            player.playerName,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                if (player.playerImage != null &&
                    player.playerImage!.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://corsproxy.io/?${player.playerImage!}',
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  )
                else
                  const Icon(Icons.person, size: 100, color: Colors.white54),
                const SizedBox(height: 12),
                buildDetailRow("Number", player.playerNumber),
                buildDetailRow("Country", player.playerCountry),
                buildDetailRow("Position", player.playerType),
                buildDetailRow("Age", player.playerAge),
                buildDetailRow("Yellow Cards", player.playerYellowCards),
                buildDetailRow("Red Cards", player.playerRedCards),
                buildDetailRow("Goals", player.playerGoals),
                buildDetailRow("Assists", player.playerAssists),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close", style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                final String message =
                    "Check out this player:\nName: ${player.playerName}\nClub: ${team.teamName ?? 'Unknown Club'}";
                Share.share(message);
              },
              child: const Text(
                "Share Player",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildDetailRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "$label:",
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              (value != null && value.toString().isNotEmpty)
                  ? value.toString()
                  : "Unknown",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              GetPlayersCubit(PlayerRepo())
                ..fetchPlayers(team.teamKey.toString()),
      child: Scaffold(
        backgroundColor: const Color(0xFF211C12),
        appBar: AppBar(
          backgroundColor: const Color(0xFF211C12),
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Players',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ),
        drawer: AppDrawer(
          user: user,
          onLogout: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
        body: BlocBuilder<GetPlayersCubit, GetPlayersState>(
          builder: (context, state) {
            if (state is GetPlayersLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetPlayersFailure) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            } else if (state is GetPlayersSuccess) {
              final List<PlayerModel> players = state.players;

              if (players.isEmpty) {
                return const Center(
                  child: Text(
                    'No players found',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              return ListView.builder(
                itemCount: players.length,
                itemBuilder: (context, index) {
                  final player = players[index];
                  return Card(
                    color: const Color(0xFF2A2519),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: ListTile(
                      onTap: () => showPlayerDetails(context, player),
                      leading:
                          player.playerImage != null &&
                                  player.playerImage!.isNotEmpty
                              ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                  'https://corsproxy.io/?${player.playerImage!}',
                                ),
                              )
                              : const CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.person, color: Colors.white),
                              ),
                      title: Text(
                        player.playerName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        player.playerType ?? 'Unknown Position',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                  );
                },
              );
            }

            return const SizedBox(); // fallback
          },
        ),
      ),
    );
  }
}
