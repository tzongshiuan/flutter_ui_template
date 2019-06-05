import 'package:meta/meta.dart' show required;
import 'package:flutter_ui_template/res/config/app_config.dart';

class Logger {
  static void log(String tag, {@required String message, bool isNeed = false}) {
    assert(tag != null);

    if (AppConfig.IS_DEBUG || isNeed) {
      print("[$tag] $message");
    }
  }
}