import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/to/login_page.dart';

import 'path/to//main.dart' as app;

class LoginUtil {
  static Future<String> login(WidgetTester tester) async {
    app.main();
    // Draw Login Page
    await tester.pumpWidget(const MaterialApp(home: Login()));

    // Enter Phone Number
    await tester.enterText(
        find.byKey(const Key('phoneNumber')), '000-0000-0000');
    await tester.pump();

    // Send Phone Number
    await tester.tap(find.byKey(const Key('sendingButton')));
    await tester.pump(const Duration(seconds: 1));

    // Enter Auth Code
    await tester.enterText(find.byKey(const Key('authCode')), '000000');
    await tester.pump(const Duration(seconds: 1));

    // Send Auth Coded
    await tester.tap(find.text('AuthButton'));
    await tester.pump(const Duration(seconds: 1));

    // Get User Id
    final userId = FirebaseAuth.instance.currentUser!.uid;

    // Test User Id
    expect(userId, 'abcdefghijklmnopqrstu');
    return userId;
  }
}

