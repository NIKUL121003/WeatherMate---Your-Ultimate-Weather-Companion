import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeData: _buildLightTheme())) {
    on<ThemeChanged>(_onThemeChanged);
  }

  static ThemeData _buildLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue[700],
      colorScheme: const ColorScheme.light().copyWith(
        secondary: Colors.blue[400],
        surface: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.grey[50],
      cardColor: Colors.white,
    );
  }

  static ThemeData _buildDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.blue[300],
      colorScheme: const ColorScheme.dark().copyWith(
        secondary: Colors.blue[200],
        surface: Colors.grey[900],
      ),
      scaffoldBackgroundColor: Colors.grey[900],
      cardColor: Colors.grey[800],
    );
  }

  void _onThemeChanged(ThemeChanged event, Emitter<ThemeState> emit) {
    emit(ThemeState(
      themeData: event.isDarkMode ? _buildDarkTheme() : _buildLightTheme(),
    ));
  }
}
