import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(_darkTheme);

  static final _lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    accentColor: secondaryColor,
    fontFamily: 'Montserrat',
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: secondarySecondaryColor),
    scaffoldBackgroundColor: Color(0xfff4f4f4),
  );

  static final _darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: backgroundColor,
    scaffoldBackgroundColor: backgroundColor,
    primaryColor: primaryColor,
    accentColor: secondaryColor,
    fontFamily: 'Montserrat',
  );

  void toggleTheme(bool isLight) {
    emit(isLight ? _lightTheme : _darkTheme);
  }
}
