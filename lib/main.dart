import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notexa/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        fontFamily: GoogleFonts.karla().fontFamily,
      ),
      home: const HomeScreen(),
    );
  }
}
