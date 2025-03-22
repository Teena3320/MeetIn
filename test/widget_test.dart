import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/login_page.dart'; // Import your login page

void main() {
  testWidgets('Login Page loads correctly', (WidgetTester tester) async {
    // Build the LoginPage and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    // Verify that the logo is displayed
    expect(find.byType(Image), findsOneWidget);

    // Verify that the text fields are displayed
    expect(find.byType(TextField), findsNWidgets(2)); // Email & Password fields

    // Verify that the login button is displayed
    expect(find.text('Login'), findsOneWidget);
  });
}
