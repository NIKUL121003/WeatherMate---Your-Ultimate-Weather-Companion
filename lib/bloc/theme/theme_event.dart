part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class ThemeChanged extends ThemeEvent {
  final bool isDarkMode;
  ThemeChanged({required this.isDarkMode});
}
