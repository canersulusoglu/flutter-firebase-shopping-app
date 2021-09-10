// ignore_for_file: file_names
import 'dart:math';
import 'package:flutter/material.dart' show Color, Colors;

Random _random = Random();

Color randomColor({double opacity = 1}){
  int red = _random.nextInt(255);
  int green = _random.nextInt(255);
  int blue = _random.nextInt(255);
  return Color.fromRGBO(red, green, blue, opacity);
}

bool colorIsDark(Color color){
  return (0.299 * color.red) + (0.587 * color.green) + (0.114 * color.blue) > 128 ? false : true;
}

Color getTextColor(Color backgroundColor){
  return colorIsDark(backgroundColor) ? Colors.white : Colors.black;
}