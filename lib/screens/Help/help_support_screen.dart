import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFFA500)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Help & Support',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.centerLeft, // Align text to the left
        child: Padding(
          padding: const EdgeInsets.only(top:34, left:73.0, right:42.0), // Add padding for spacing
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
            children: const [
              Text(
                'Need Assistance?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'We\'re here to help! You can reach out to us\nthrough the following channels:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 32),
              Text(
                'Facebook Support',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Prefer connecting on social media?\nMessage us directly on our Facebook\npage for quick assistance.',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 32),
              Text(
                'Email Support:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Have a question or need help with\nsomething? Send us an email at\nhello@jeepadsph.com, and we’ll get\nback to you within 24–48 hours.',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
