import 'package:flutter/material.dart';

class AppTheme {
  ThemeData lightTheme = ThemeData(
      primaryColor: const Color.fromARGB(255, 255, 255, 255),
      secondaryHeaderColor: Colors.grey,
      scaffoldBackgroundColor: const Color.fromARGB(255, 232, 235, 239),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
      ),
      tabBarTheme: const TabBarTheme(
          unselectedLabelColor: Color.fromARGB(255, 56, 56, 56)),
      useMaterial3: true,
      brightness: Brightness.light,
      iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(iconSize: MaterialStatePropertyAll(30))),
      textTheme: const TextTheme(
          bodySmall: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 105, 105, 105),
              fontSize: 16),
          bodyLarge: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 105, 105, 105),
              fontSize: 25),
          labelLarge: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 20),
          displaySmall: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
              color: Color.fromARGB(255, 59, 59, 59),
              fontSize: 15),
          titleMedium: TextStyle(
              fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 21),
          titleSmall: TextStyle(
              fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 16),
          bodyMedium: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(255, 87, 87, 87),
              fontSize: 18),
          displayMedium: TextStyle(
              fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 20),
          titleLarge: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 30)),
      appBarTheme: const AppBarTheme(
          centerTitle: true,
          shadowColor: Colors.black,
          titleTextStyle: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 30)));
  ThemeData darkTheme = ThemeData(
      dividerColor: Colors.white,
      primaryColor: const Color.fromARGB(255, 35, 35, 35),
      scaffoldBackgroundColor: const Color.fromARGB(255, 17, 17, 17),
      tabBarTheme: const TabBarTheme(
          unselectedLabelColor: Color.fromARGB(255, 56, 56, 56)),
      useMaterial3: true,
      brightness: Brightness.dark,
      iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(iconSize: MaterialStatePropertyAll(30))),
      textTheme: const TextTheme(
          bodySmall: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 209, 209, 209),
              fontSize: 16),
          bodyLarge: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 209, 209, 209),
              fontSize: 25),
          labelLarge: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 20),
          displaySmall: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
              color: Color.fromARGB(255, 209, 209, 209),
              fontSize: 15),
          titleMedium: TextStyle(
              fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 21),
          titleSmall: TextStyle(
              fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 16),
          bodyMedium: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(255, 216, 216, 216),
              fontSize: 18),
          displayMedium: TextStyle(
              fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 20),
          titleLarge: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 30)),
      appBarTheme: const AppBarTheme(
          centerTitle: true,
          shadowColor: Color.fromARGB(255, 255, 255, 255),
          titleTextStyle: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 30)));
}
