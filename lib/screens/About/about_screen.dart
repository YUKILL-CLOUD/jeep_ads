import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
          'About',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
          body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 42, right: 42, top: 42, bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Company Logo
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.yellow[700],
              child: Icon(
                Icons.business,
                size: 60,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),

            // Company Name
            Text(
              'Tech Innovators',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.yellow[900],
              ),
            ),
            SizedBox(height: 10),

            // Tagline
            Text(
              'Innovating the Future',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Colors.yellow[800],
              ),
            ),
            SizedBox(height: 30),

            // Mission Section
            _buildSection(
              title: 'Our Mission',
              content:
                  'To deliver cutting-edge technology solutions that empower businesses and individuals to achieve their goals.',
            ),
            SizedBox(height: 20),

            // Story Section
            _buildSection(
              title: 'Our Story',
              content:
                  'Founded in 2025, Tech Innovators started as a small team of passionate developers. Today, we are a global leader in software development, AI, and cloud solutions.',
            ),
            SizedBox(height: 20),

            // Team Section
            _buildSection(
              title: 'Our Team',
              content:
                  'Our team consists of experienced professionals dedicated to innovation, quality, and customer satisfaction.',
            ),
            SizedBox(height: 20),

            // Contact Section  
            _buildSection(
              title: 'Contact Us',
              content:
                  'Email: info@techinnovators.com\nPhone: +1 234 567 890\ villa Iloilo',
            ),
            SizedBox(height: 20),

            // Call to Action Button
            ElevatedButton(
              onPressed: () {
                // Add action here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Thanks for reaching out!'),
                    backgroundColor: Colors.yellow[700],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[700], // Yellow button
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Get in Touch',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build sections
  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.yellow[900],
          ),
        ),
        SizedBox(height: 10),
        Text(
          content,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }
}