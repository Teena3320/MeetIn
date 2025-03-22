import 'package:flutter/material.dart';

class OTPVerificationPage extends StatelessWidget {
  final String enteredValue;

  OTPVerificationPage({required this.enteredValue});

  @override
  Widget build(BuildContext context) {
    TextEditingController otpController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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

          SizedBox(height: 30), // Space before text
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
                  enteredValue, // Display email/phone on the next line
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          SizedBox(height: 16), // Space before input field
          // OTP Input Field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 80),
            child: TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Enter OTP"),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 200), // Space before button
          // Verify Button
          Center(
            child: SizedBox(
              width: 100, // Same width as other buttons
              height: 40, // Same height as other buttons
              child: ElevatedButton(
                onPressed: () {
                  print("OTP Entered: ${otpController.text}");
                  // Handle OTP verification logic here
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
