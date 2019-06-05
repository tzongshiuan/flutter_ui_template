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

  void printStack(StackTrace stackTrace, int stackNum, Function log) {
    if (stackTrace != null) {
      var array = stackTrace.toString().split('\n');
      String stackLog = "";
      int lineNum = 0;

      for (var str in array) {
        if (lineNum != 0) {
          stackLog += '\n';
        }

        stackLog += str;
        lineNum++;

        if (lineNum == stackNum) {
          break;
        }
      }

      log(stackLog);
    }
  }

  void finest({@required String message, bool isNeed = false, StackTrace stackTrace, int stackNum = 1}) {
    if (AppConfig.IS_DEBUG || isNeed) {
      printStack(stackTrace, stackNum, _logger.finest);
      _logger.finest("$message");
    }
  }

  void finer({@required String message, bool isNeed = false, StackTrace stackTrace, int stackNum = 1}) {
    if (AppConfig.IS_DEBUG || isNeed) {
      printStack(stackTrace, stackNum, _logger.finer);
      _logger.finer("$message");
    }
  }

  void fine({@required String message, bool isNeed = false, StackTrace stackTrace, int stackNum = 1}) {
    if (AppConfig.IS_DEBUG || isNeed) {
      printStack(stackTrace, stackNum, _logger.fine);
      _logger.fine("$message");
    }
  }

  void config({@required String message, bool isNeed = false, StackTrace stackTrace, int stackNum = 1}) {
    if (AppConfig.IS_DEBUG || isNeed) {
      _logger.config("$message");
    }
  }

  void info({@required String message, bool isNeed = false, StackTrace stackTrace, int stackNum = 1}) {
    if (AppConfig.IS_DEBUG || isNeed) {
      printStack(stackTrace, stackNum, _logger.info);
      _logger.info("$message");
    }
  }

  void warning({@required String message, bool isNeed = false, StackTrace stackTrace, int stackNum = 1}) {
    if (AppConfig.IS_DEBUG || isNeed) {
      printStack(stackTrace, stackNum, _logger.warning);
      _logger.warning("$message");
    }
  }

  void severe({@required String message, bool isNeed = false, StackTrace stackTrace, int stackNum = 1}) {
    if (AppConfig.IS_DEBUG || isNeed) {
      printStack(stackTrace, stackNum, _logger.severe);
      _logger.severe("$message");
    }
  }

  void shout({@required String message, bool isNeed = false, StackTrace stackTrace, int stackNum = 1}) {
    if (AppConfig.IS_DEBUG || isNeed) {
      printStack(stackTrace, stackNum, _logger.shout);
      _logger.shout("$message");
    }
  }
}