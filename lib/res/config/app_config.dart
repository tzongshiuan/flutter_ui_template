import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class AppConfig {
  static const bool IS_ENABLE_SPLASH = false;

  static const bool IS_DEBUG = bool.fromEnvironment("dart.vm.product") == false;
  static const Level DEBUG_LEVEL = Level.ALL;
}