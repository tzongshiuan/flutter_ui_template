import 'dart:ui';
import 'package:flutter/material.dart';

class AppConfig {
  static const bool IS_ENABLE_SPLASH = true;

  static const bool IS_DEBUG = bool.fromEnvironment("dart.vm.product") == false;
}