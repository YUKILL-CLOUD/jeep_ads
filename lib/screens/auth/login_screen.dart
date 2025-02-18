import 'package:flutter/material.dart';
import '../../widgets/auth/auth_buttons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 255, 255, 255),
              const Color.fromARGB(255, 255, 255, 255),
              const Color.fromARGB(255, 255, 255, 255),// Your specified color
              const Color.fromARGB(255, 255, 255, 255),
              const Color.fromARGB(255, 255, 255, 255),
                const Color.fromARGB(255, 255, 255, 255),
                       const Color.fromARGB(255, 255, 255, 255),    
               const Color(0xFFFFB222).withOpacity(0.4),  
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 0.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0.0),
                        child: Image.asset(
                          'lib/images/login_logo.png',
                          height: 80,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Text(
                              'JEEP ADS',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Drive Your\nMessage Further!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 20/20,
                          color: Color(0xFFFFB222),
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                       const Text(
                        'Reach thousand of\n commuters daily with impactful, affordable,\nand localized advertising.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 20/20,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                      //divider with sign in via in the middle 
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.black,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Sign in via',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.black,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const AuthButtons(),
                      const SizedBox(height: 24),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                          children: [
                            const TextSpan(text: 'By signing up, you agree to the '),
                            TextSpan(
                              text: 'Terms and Service',
                              style: TextStyle(
                                color: Colors.black,
                                 fontWeight: FontWeight.bold,

                              ),
                            ),
                            const TextSpan(text: ', and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                 color: Colors.black,
                                 fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(text: ', including '),
                            TextSpan(
                              text: 'Cookie Use',
                              style: TextStyle(
                             color: Colors.black,
                                 fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(text: '.'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Bottom text with padding
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      children: [
                        const TextSpan(text: 'Don\'t have an account? ',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          height: 14/21,
                        ),
                        ),
                        TextSpan(
                          text: 'Get Started',
                          style: TextStyle(
                            fontSize: 14,
                            height: 14/21,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 