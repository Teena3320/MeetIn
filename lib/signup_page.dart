import 'package:flutter/material.dart';
import 'firestore_service.dart';
import 'otp_verification_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirestoreService _firestoreService = FirestoreService();
  bool isEmailSignUp = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String selectedCountryCode = "+91"; // Default country code
  String? errorMessage;

  Future<void> handleSignUp() async {
    String? email = isEmailSignUp ? emailController.text.trim() : null;
    String? phone = !isEmailSignUp ? phoneController.text.trim() : null;

    //  Validate Email
    if (isEmailSignUp) {
      if (email == null ||
          !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email)) {
        setState(() {
          errorMessage = " Enter a valid email address!";
        });
        return;
      }
    }
    //  Validate Phone Number
    else {
      if (phone == null ||
          phone.isEmpty ||
          !RegExp(r'^[0-9]{8,15}$').hasMatch(phone)) {
        setState(() {
          errorMessage = " Enter a valid phone number!";
        });
        return;
      }
      phone = "$selectedCountryCode$phone"; // Append country code
    }

    //  Clear error messages if everything is valid
    setState(() {
      errorMessage = null;
    });

    print(" Checking if user exists...");
    bool exists = await _firestoreService.checkUserExists(email, phone);
    if (exists) {
      print(" User already exists!");
      return;
    }

    print(" Creating user...");
    int newUID = await _firestoreService.createUser(email: email, phone: phone);
    print(" New user created with UID$newUID");

    //  Navigate to OTP Verification
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => OTPVerificationPage(
              enteredValue: isEmailSignUp ? email! : phone!,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Building Widget...");
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
                  keyboardType: TextInputType.emailAddress,
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
