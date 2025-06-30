import 'package:flutter/material.dart';
import 'package:sports_app/data/google_sign_in_service.dart';
import 'package:sports_app/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF211C12),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 60),
                Image(
                  image: AssetImage(
                    '../assets/images/google-2-removebg-preview.png',
                  ),
                  width: 150,
                ),
                // SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final userCredential =
                          await GoogleSignInService.signInWithGoogle();

                      if (userCredential != null) {
                        final user = userCredential.user!;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(user: user),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Google Sign-In Failed')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF473D24),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.login, color: Colors.white, size: 14),
                        SizedBox(width: 10),
                        Text(
                          'Login with Google',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Color(0xFF473D24),
        child: Center(
          child: Text(
            'Runnova',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: "logo",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
