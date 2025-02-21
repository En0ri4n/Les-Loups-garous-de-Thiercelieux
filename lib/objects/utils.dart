
import 'dart:math';

class Utils {
  static Random random = Random();

  static T getRandom<T>(List<T> list) {
    return list[random.nextInt(list.length)];
  }

  static void setRandomSeed(int seed) {
    random = Random(seed);
  }

  static String getFormmatedTime(int duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitHours = twoDigits(duration ~/ 3600);
    String twoDigitMinutes = twoDigits(duration ~/ 60);
    String twoDigitSeconds = twoDigits(duration % 60);
    return "${duration ~/ 3600 > 0 ? '$twoDigitHours:' : ''}${duration ~/ 60 > 0 ? '$twoDigitMinutes:' : ''}$twoDigitSeconds";
  }
}
