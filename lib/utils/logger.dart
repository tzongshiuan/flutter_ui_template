import 'package:meta/meta.dart' show required;
import 'package:logging/logging.dart';
import 'package:flutter_ui_template/res/config/app_config.dart';

//static const List<Level> LEVELS = const [
//  ALL,
//  FINEST,
//  FINER,
//  FINE,
//  CONFIG,
//  INFO,
//  WARNING,
//  SEVERE,
//  SHOUT,
//  OFF
//];

class Log {
  Log(this._tag) {
    assert(_tag != null);
    _logger = new Logger(_tag);
  }
  final String _tag;
  Logger _logger;

  void finest({@required String message, bool isNeed = false}) {
    if (AppConfig.IS_DEBUG || isNeed) {
      _logger.finest("$message");
    }
  }

  void finer({@required String message, bool isNeed = false}) {
    if (AppConfig.IS_DEBUG || isNeed) {
      _logger.finer("$message");
    }
  }

  void fine({@required String message, bool isNeed = false}) {
    if (AppConfig.IS_DEBUG || isNeed) {
      _logger.fine("$message");
    }
  }

  void config({@required String message, bool isNeed = false}) {
    if (AppConfig.IS_DEBUG || isNeed) {
      _logger.config("$message");
    }
  }

  void info({@required String message, bool isNeed = false}) {
    if (AppConfig.IS_DEBUG || isNeed) {
      _logger.info("$message");
    }
  }

  void warning({@required String message, bool isNeed = false}) {
    if (AppConfig.IS_DEBUG || isNeed) {
      _logger.warning("$message");
    }
  }

  void severe({@required String message, bool isNeed = false}) {
    if (AppConfig.IS_DEBUG || isNeed) {
      _logger.severe("$message");
    }
  }

  void shout({@required String message, bool isNeed = false}) {
    if (AppConfig.IS_DEBUG || isNeed) {
      _logger.shout("$message");
    }
  }
}