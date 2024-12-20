import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduan_test/ClassAndServices/AuthToken/AuthToken.dart';
import 'package:graduan_test/UserInterface/MainPages/SigInAndHomePage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Graduan Test App',
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: ThemeMode.system,
      home: const SignInAndHomePage(),
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      textTheme: GoogleFonts.latoTextTheme(ThemeData.light().textTheme),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue,
        titleTextStyle: GoogleFonts.lato(color: Colors.white, fontSize: 20),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.blue,
        textTheme: ButtonTextTheme.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: Colors.blueGrey,
      scaffoldBackgroundColor: Colors.black,
      textTheme: GoogleFonts.latoTextTheme(ThemeData.dark().textTheme),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blueGrey,
        titleTextStyle: GoogleFonts.lato(color: Colors.white, fontSize: 20),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.blueGrey,
        textTheme: ButtonTextTheme.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey),
        ),
      ),
    );
  }
}




