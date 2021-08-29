// ignore_for_file: file_names
import 'package:flutter/material.dart';

extension ThemeDataExtensions on ThemeData {
  static final Map<ColorScheme, AdditionalColorScheme> _colorScheme = {};

  void addAdditionalColorScheme(AdditionalColorScheme colorScheme) {
    _colorScheme[this.colorScheme] = colorScheme;
  }

  static AdditionalColorScheme? empty;

  AdditionalColorScheme get additionalColorScheme {
    var o = _colorScheme[colorScheme];
    o ??= AdditionalColorScheme.empty();
    return o;
  }
}

class AdditionalColorScheme {
  final Color success;
  final Color onSuccess;

  const AdditionalColorScheme({
    required this.success, 
    required this.onSuccess
  });

  factory AdditionalColorScheme.empty() {
    return const AdditionalColorScheme(success: Colors.green, onSuccess: Colors.black);
  }
}

AdditionalColorScheme additionalColorScheme(BuildContext context) => Theme.of(context).additionalColorScheme;

final ThemeData lightTheme = (ThemeData.light().copyWith(
  colorScheme: const ColorScheme.light(
    primary: Colors.orange,
    secondary: Colors.lightBlue,
  )
))..addAdditionalColorScheme(const AdditionalColorScheme(
  success: Colors.green,
  onSuccess: Colors.black
));

final ThemeData darkTheme = (ThemeData.dark().copyWith(
  colorScheme: const ColorScheme.dark(
    primary: Colors.orange,
    secondary: Colors.lightBlue,
  )
))..addAdditionalColorScheme(const AdditionalColorScheme(
  success: Colors.green,
  onSuccess: Colors.black
));