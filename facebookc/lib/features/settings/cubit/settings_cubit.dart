// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:facebookc/core/theme.dart';
import 'package:flutter/material.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial(themeData: AppTheme().lightTheme));
  void toggleTheme() {
    if (state.themeData == AppTheme().lightTheme) {
      emit(SettingsInitial(themeData: AppTheme().darkTheme));
    } else {
      emit(SettingsInitial(themeData: AppTheme().lightTheme));
    }
  }
}
