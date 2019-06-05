import 'package:flutter/material.dart';
import 'package:flutter_ui_template/pages/home/home_screen.dart';
import 'package:flutter_ui_template/pages/splash/splash_screen.dart';
import 'package:flutter_ui_template/res/config/app_config.dart';
import 'package:flutter_ui_template/utils/my_navigator.dart';
import 'package:flutter_ui_template/utils/logger.dart';
import 'package:logging/logging.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_ui_template/generated/i18n.dart';

final Log _logger = Log('main');

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) {
    if (AppConfig.IS_ENABLE_SPLASH)
      return MyHomePage(title: S.of(context).title);
    else {
      return MyHomePage(title: const S().title);
    }
  },
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
        print('[${rec.level.name}][${rec.time}][${rec.loggerName}]: ${rec.message}');
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _logger.fine(message: 'is debug mode: ${AppConfig.IS_DEBUG}', stackTrace: StackTrace.current);

    return MaterialApp(
      title: 'Flutter UI Demo',
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
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      // Have problem here
      //localeResolutionCallback: S.delegate.resolution(fallback: Locale("en", "")),
    );
  }
}