
import 'package:werewolves_of_thiercelieux/objects/color_helper.dart';

class Settings {
  late bool darkMode;
  late bool sound;

  late ThemeColor themeColor;

  Settings({
    required this.darkMode,
    required this.sound,
    required this.themeColor,
  });

  factory Settings.defaultSettings() {
    return Settings(
      darkMode: false,
      sound: true,
      themeColor: ColorHelper.lightTheme,
    );
  }

  factory Settings.deserialize(Map<String, dynamic> json) {
    return Settings(
      darkMode: json['darkMode'],
      sound: json['sound'],
      themeColor: json['darkMode'] ? ColorHelper.darkTheme : ColorHelper.lightTheme,
    );
  }

  Map<String, dynamic> serialize() {
    return {
      'darkMode': darkMode,
      'sound': sound,
    };
  }
}