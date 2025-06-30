// app_drawer.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppDrawer extends StatelessWidget {
  final User user;
  final VoidCallback onLogout;

  const AppDrawer({super.key, required this.user, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF211C12),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF473D24)),
              accountName: Text(user.displayName ?? "No name"),
              accountEmail: Text(user.email ?? "No email"),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Color(0xFFF5C754), size: 20.0),
              title: Text(
                'Log out',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: onLogout,
            ),
          ],
        ),
      ),
    );
  }
}
