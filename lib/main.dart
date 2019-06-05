import 'package:flutter/material.dart';
import 'package:flutter_ui_template/pages/home/home_screen.dart';
import 'package:flutter_ui_template/pages/splash/splash_screen.dart';
import 'package:flutter_ui_template/res/config/app_config.dart';
import 'package:flutter_ui_template/utils/my_navigator.dart';
import 'package:flutter_ui_template/utils/logger.dart';
import 'package:logging/logging.dart';

final Log _logger = Log('main');

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => MyHomePage(title: 'Flutter Demo Home Page'),
};

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MyApp() {
    _configureLogger();
  }

  void _configureLogger() {
    Logger.root.level = AppConfig.DEBUG_LEVEL;
    Logger.root.onRecord.listen((LogRecord rec) {
      if (AppConfig.IS_DEBUG) {
        print(
            '[${rec.level.name}][${rec.time}][${rec.loggerName}]: ${rec.message}');
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _logger.fine(message: 'is debug mode: ${AppConfig.IS_DEBUG}');

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      showSemanticsDebugger: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AppConfig.IS_ENABLE_SPLASH
        ? SplashScreen()
        : routes["/home"](context),
      routes: routes,
    );
  }
}