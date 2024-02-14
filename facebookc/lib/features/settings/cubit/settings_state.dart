part of 'settings_cubit.dart';

sealed class SettingsState {
  final ThemeData themeData;

  SettingsState({required this.themeData});
}

final class SettingsInitial extends SettingsState {
  SettingsInitial({required super.themeData});
}
