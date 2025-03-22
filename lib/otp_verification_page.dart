import 'package:flutter/material.dart';
import 'create_profile.dart'; // Import the Create Profile Page

class OTPVerificationPage extends StatelessWidget {
  final String enteredValue; // Email or Phone Number

  OTPVerificationPage({required this.enteredValue});

  @override
  Widget build(BuildContext context) {
    TextEditingController otpController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          // Back Arrow & Logo
          Row(
            children: [
              SizedBox(width: 65),
              IconButton(
                icon: Icon(Icons.arrow_back, size: 30),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Center(
                  child: Image.asset("assets/logo.png", height: 80),
                ),
              ),
              SizedBox(width: 111),
            ],
          ),

          SizedBox(height: 30),
          // Centered Text
          Center(
            child: Column(
              children: [
                Text(
                  "A verification code has been sent to:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  enteredValue, // Show Email/Phone
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          SizedBox(height: 16),

          // OTP Input Field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 80),
            child: TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Enter OTP"),
            ),
          ),

          SizedBox(height: 228),

          // Verify Button
          Center(
            child: SizedBox(
              width: 100,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  String otp = otpController.text;
                  if (otp.length == 6) {
                    // Basic OTP validation
                    print("OTP Verified Successfully!");

                    // Navigate to Create Profile Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateProfilePage(),
                      ),
                    );
                  } else {
                    // Show error message if OTP is invalid
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Invalid OTP! Please try again.")),
                    );
                  }
                },
                child: Text("Verify"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
