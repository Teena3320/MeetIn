import 'package:flutter/material.dart';
import 'otp_verification_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isEmailSignUp = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String selectedCountryCode = "+91"; // Default country code

  void handleSignUp() {
    String enteredValue =
        isEmailSignUp
            ? emailController.text
            : "$selectedCountryCode ${phoneController.text}";

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OTPVerificationPage(enteredValue: enteredValue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align back arrow
          children: [
            SizedBox(height: 50), // Space from top
            // Back Arrow & Logo
            Row(
              children: [
                SizedBox(width: 65), // Space from left
                IconButton(
                  icon: Icon(Icons.arrow_back, size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Center(
                    child: Image.asset("assets/logo.png", height: 80),
                  ),
                ),
                SizedBox(
                  width: 111,
                ), // Maintain spacing balance (same as icon size)
              ],
            ),

            SizedBox(height: 30), // Space before toggle
            Center(
              child: ToggleButtons(
                isSelected: [isEmailSignUp, !isEmailSignUp],
                onPressed: (int index) {
                  setState(() {
                    isEmailSignUp = (index == 0);
                  });
                },
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Email Sign Up"),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Phone Sign Up"),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20), // Space before first input

            if (isEmailSignUp) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 80),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: "Email"),
                ),
              ),
            ] else ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 80),
                child: Row(
                  children: [
                    DropdownButton<String>(
                      value: selectedCountryCode,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCountryCode = newValue!;
                        });
                      },
                      items:
                          ["+1", "+91", "+44", "+61"].map((code) {
                            return DropdownMenuItem(
                              value: code,
                              child: Text(code),
                            );
                          }).toList(),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(labelText: "Phone Number"),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            SizedBox(height: 228), // Space before button

            Center(
              child: SizedBox(
                width: 100, // Same width as Login button
                height: 40, // Same height as Login button
                child: ElevatedButton(
                  onPressed: handleSignUp,
                  child: Text("Sign Up"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
