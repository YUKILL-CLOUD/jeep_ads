import 'package:flutter/material.dart';
import '../advertise/advertise_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  int _selectedIndex = 1; // Set to 1 for Profile tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFFA500)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Account',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Color.fromARGB(255, 255, 255, 255), size: 60),
              ),
              const SizedBox(height: 16),
              const Text(
                'Cedrick Sabrine',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    'Profile Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              _buildAccountField(
                icon: Icons.person,
                label: 'Full Name',
                value: 'Cedrick Sabrine',
              ),
              _buildAccountField(
                icon: Icons.email,
                label: 'Email',
                value: 'cedrick.sabrine@example.com',
              ),
              _buildAccountField(
                icon: Icons.phone,
                label: 'Mobile Number',
                value: '+63 917 123 4567',
              ),  
              _buildAccountField(
                icon: Icons.location_on,
                label: 'Location',
                value: 'Iloilo City, Iloilo',
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 50),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdvertiseScreen(),
                ),
              );
            },
            shape: const CircleBorder(),
            backgroundColor: const Color.fromARGB(221, 12, 9, 60),
            child: const Icon(Icons.add, color: Colors.white),
          ),
          const SizedBox(height: 4),
          const Text(
            'Advertise Now',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(221, 12, 9, 60),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavBarItem(0, Icons.tv_outlined, 'Ads'),
            const SizedBox(width: 48), // Space for FAB
            _buildNavBarItem(1, Icons.person_outline, 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountField({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Icon as a standalone element on the left side
                Icon(
                  icon,
                  size: 30,
                  color: const Color.fromARGB(255, 0, 0, 0), // Color for the icon
                ),
                const SizedBox(width: 12),
                
                // Column to display label and value together on the right side
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Label on top
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,  // Color for the label
                      ),
                    ),
                    const SizedBox(height: 4), // Space between label and value
                    // Value aligned on the same line as label
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87, // Color for the value text
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavBarItem(int index, IconData icon, String label) {
    final isSelected = _selectedIndex == index;
    
    return InkWell(
      onTap: () {
        if (index == 0) {
          // Navigate to Ads (Home)
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        } else if (index == 1) {
          // Navigate to Profile
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const UserProfilePage(),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  icon,
                  color: isSelected 
                      ? Theme.of(context).primaryColor 
                      : Colors.grey,
                ),
                if (index == 0)
                  Positioned(
                    child: Icon(
                      Icons.play_circle_outline,
                      size: 12,
                      color: isSelected 
                          ? Theme.of(context).primaryColor 
                          : Colors.grey,
                    ),
                  ),
              ],
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected 
                    ? Theme.of(context).primaryColor 
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
