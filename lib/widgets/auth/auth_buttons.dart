import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class AuthButtons extends StatelessWidget {
  const AuthButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Google Sign In Button
        ElevatedButton(
          onPressed: () => AuthService.signInWithGoogle(context),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 1,
            minimumSize: const Size(double.infinity, 64),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            
            children: [
             Image.asset(
                          'lib/images/google.png',
                          height: 36,
                          width: 36,
                          fit: BoxFit.contain,
                          ),
              const SizedBox(width: 12),
              const Text(
                'Continue with Google',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 14/21,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Apple Sign In Button
        ElevatedButton(
          onPressed: () => AuthService.signInWithApple(context),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16),
            backgroundColor: Colors.white,
            foregroundColor:  Colors.black,
            elevation: 1,
            minimumSize: const Size(double.infinity, 64),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                          'lib/images/apple.png',
                          height: 36,
                          width: 36,
                          fit: BoxFit.contain,
                          
                          ),
              const SizedBox(width: 12),
              const Text(
                'Continue with Apple',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 14/21,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
} 