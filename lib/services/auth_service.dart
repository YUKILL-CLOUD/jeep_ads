// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '../screens/auth/phone_verification_screen.dart';

class AuthService {
  static Future<void> signInWithGoogle(BuildContext context) async {
    // TODO: Implement actual Google sign in
    print('Sign in with Google pressed');
    // Navigate to phone verification
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PhoneVerificationScreen(),
      ),
    );
  }

  static Future<void> signInWithApple(BuildContext context) async {
    // TODO: Implement actual Apple sign in
    print('Sign in with Apple pressed');
    // Navigate to phone verification
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PhoneVerificationScreen(),
      ),
    );
  }
} 