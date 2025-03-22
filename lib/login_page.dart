import 'package:flutter/material.dart';
import 'signup_page.dart'; // Import the SignUpPage file

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isEmailLogin = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String selectedCountryCode = "+1"; // Default country code

  void handleSubmit() {
    if (isEmailLogin) {
      print("Username: ${usernameController.text}");
      print("Password: ${passwordController.text}");
    } else {
      print("Phone: $selectedCountryCode ${phoneController.text}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50), // Logo locked at height 50
            Image.asset(
              "assets/logo.png",
              height: 80,
            ), // Replace with your logo

            SizedBox(height: 100), // Space before toggle (total height 80)

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: "Email/Username/Phone"),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
            ),

            SizedBox(height: 160), // Space before button

            SizedBox(
              width: 100, // Same width for both buttons
              height: 40, // Same height for both buttons
              child: ElevatedButton(
                onPressed: handleSubmit,
                child: Text("Login"),
              ),
            ),

            SizedBox(height: 20), // Space before Sign Up
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpPage(),
                  ), // Navigate to SignUpPage
                );
              },
              child: Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
