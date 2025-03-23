import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CreateProfilePage extends StatefulWidget {
  @override
  _CreateProfilePageState createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  File? _profileImage; // Stores selected image
  final ImagePicker _picker = ImagePicker(); // Image Picker instance

  // Function to pick an image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path); // Update UI with selected image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 68), // Space from top
          // Back Arrow & Create Profile Banner
          Row(
            children: [
              SizedBox(width: 65), // Spacing same as OTP page
              IconButton(
                icon: Icon(Icons.arrow_back, size: 30),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Create Profile",
                    style: TextStyle(
                      fontSize: 24, // Matches logo size from OTP page
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 111), // Same as icon spacing in OTP page
            ],
          ),

          SizedBox(height: 16),

          // Profile Picture Upload
          Center(
            child: GestureDetector(
              onTap: _pickImage, // Open gallery when tapped
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                backgroundImage:
                    _profileImage != null ? FileImage(_profileImage!) : null,
                child:
                    _profileImage == null
                        ? Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: Colors.grey[700],
                        )
                        : null,
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 80), // Same as OTP page
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    // SizedBox(height: 28),

                    // Username Field
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: "Name"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Mandatory*";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 10),

                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(labelText: "Username"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Mandatory*";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 170),
                    // Submit Button
                    Center(
                      child: SizedBox(
                        width: 100, // Same width as OTP Verify button
                        height: 40, // Same height as OTP Verify button
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print("Username: ${usernameController.text}");
                              print("Bio: ${bioController.text}");
                              print("Profile Image: ${_profileImage?.path}");
                            }
                          },
                          child: Text("Next"),
                        ),
                      ),
                    ),

                    SizedBox(height: 50), // Ensure bottom spacing
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
