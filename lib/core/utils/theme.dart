import 'package:flutter/material.dart';

class _ColorScheme {
  final ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 221, 67, 244),
    brightness: Brightness.dark,
  );
}

final _ColorScheme _colorScheme = _ColorScheme();

class ThemeDataModel extends ChangeNotifier {
  static ThemeDataModel? _instance;
  final ThemeData _themeDataDark = ThemeData(
    useMaterial3: true,
    colorScheme: _colorScheme.colorScheme,
    brightness: Brightness.dark,
    inputDecorationTheme: InputDecorationTheme(
      errorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          width: 1,
          color: _colorScheme.colorScheme.error,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          width: 1,
          color: _colorScheme.colorScheme.onBackground,
        ),
      ),
      enabledBorder:  OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          width: 1,
          color: _colorScheme.colorScheme.onBackground,
        ),
      ),
      focusedBorder:  OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: _colorScheme.colorScheme.primary,
        ),
      ),
      suffixIconColor: _colorScheme.colorScheme.primary,
      prefixIconColor: _colorScheme.colorScheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _colorScheme.colorScheme.onPrimary,
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: .56,
        foregroundColor: _colorScheme.colorScheme.onBackground,
      ),
    ),
  );
  late final ThemeData _themeDataLight;
  late ThemeData _themData;

  ThemeData getTheme() => _themData;

  ThemeDataModel._internal() {
    _themeDataLight = _themeDataDark.copyWith(brightness: Brightness.light);
  }

  factory ThemeDataModel() {
    _instance ??= ThemeDataModel._internal();
    return _instance!;
  }

  Future<void> init() async {
    // ToDo: make a way to read if app is light or dark mode.
    _themData = _themeDataDark;
  }
}
