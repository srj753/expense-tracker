import 'package:flutter/material.dart';

import 'package:expense_tracker/expenses.dart';

final kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 233, 246, 142));
final kdColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.deepPurpleAccent, brightness: Brightness.dark);
void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kdColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kdColorScheme.onPrimary,
            foregroundColor: kdColorScheme.onPrimaryContainer),
        cardTheme: const CardTheme().copyWith(
            color: kdColorScheme.onSecondary,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kdColorScheme.onPrimary,
              foregroundColor: kdColorScheme.onPrimaryContainer),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              bodyLarge: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: kdColorScheme.onPrimaryContainer),
              titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: kdColorScheme.onPrimaryContainer),
              displayLarge: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: kdColorScheme.onPrimaryContainer),
            ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: kdColorScheme.onPrimaryContainer),
        ),
      ),
      theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kColorScheme.onPrimaryContainer,
              foregroundColor: kColorScheme.onPrimary),
          cardTheme: const CardTheme().copyWith(
              color: kColorScheme.onSecondary,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kColorScheme.inversePrimary,
                foregroundColor: kColorScheme.onPrimary),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                displayLarge: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: kColorScheme.onPrimaryContainer),
              )),
      home: const Expenses(),
      themeMode: ThemeMode.system,
    ),
  );
}
