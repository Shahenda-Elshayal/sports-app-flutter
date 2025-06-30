import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sports_app/data/google_sign_in_service.dart';
import 'login_screen.dart';
import '../widgets/app_drawer.dart';
import 'countries_screen.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  static const List<Map<String, dynamic>> sports = [
    {"name": "Football", "image": "assets/images/football-488714_1280.jpg"},
    {
      "name": "BasketBall",
      "image": "assets/images/basketball-6687953_1280.jpg",
    },
    {"name": "Cricket", "image": "assets/images/cricket-8444899_1280.jpg"},
    {"name": "Tennis", "image": "assets/images/wilson-2259352_1280.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF211C12),

      appBar: AppBar(
        backgroundColor: const Color(0xFF473D24),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Runnova',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: "logo",
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

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children:
              sports.map((sport) {
                return GestureDetector(
                  onTap: () {
                    if (sport["name"] != "Football") {
                      showDialog(
                        context: context,
                        builder:
                            (ctx) => AlertDialog(
                              backgroundColor: const Color(0xFF211C12),
                              title: Text(
                                "Coming soon",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Text(
                                "This feature will be available soon.",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(ctx).pop(),
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CountriesScreen(user: user),
                        ),
                      );
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Image.asset(sport["image"]!, fit: BoxFit.cover),
                      ),
                      SizedBox(height: 8),
                      Text(
                        sport["name"]!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
