// ignore_for_file: avoid_print



import 'package:flutter/material.dart';

import 'screens/auth/login_screen.dart';



void main() {

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {

  const MyApp({super.key});


  @override

  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Jeep Ads',

      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),

        useMaterial3: true,

        fontFamily: 'Poppins',

        textTheme: const TextTheme().apply(

          fontFamily: 'Poppins',

        ),

      ),

      home: const LoginScreen(),

    );

  }

}


