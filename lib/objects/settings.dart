
import 'package:werewolves_of_thiercelieux/objects/color_helper.dart';

class Settings {
  late bool darkMode;
  late bool sound;
  late Duration defaultChrono;

  late ThemeColor themeColor;

  Settings({
    required this.darkMode,
    required this.sound,
    required this.themeColor,
    required this.defaultChrono,
  });

  factory Settings.defaultSettings() {
    return Settings(
      darkMode: false,
      sound: true,
      themeColor: ColorHelper.lightTheme,
      defaultChrono: const Duration(minutes: 5),
    );
  }

  factory Settings.deserialize(Map<String, dynamic> json) {
    return Settings(
      darkMode: json['darkMode'],
      sound: json['sound'],
      themeColor: json['darkMode'] ? ColorHelper.darkTheme : ColorHelper.lightTheme,
      defaultChrono: Duration(seconds: json['defaultChrono']),
    );
  }

  Map<String, dynamic> serialize() {
    return {
      'darkMode': darkMode,
      'sound': sound,
      'defaultChrono': defaultChrono.inSeconds,
    };
  }
}