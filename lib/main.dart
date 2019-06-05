import 'package:flutter/material.dart';
import 'package:flutter_ui_template/pages/home/home_screen.dart';
import 'package:flutter_ui_template/pages/splash/splash_screen.dart';
import 'package:flutter_ui_template/res/config/app_config.dart';
import 'package:flutter_ui_template/utils/my_navigator.dart';
import 'package:flutter_ui_template/utils/logger.dart';


const String TAG = 'main';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => MyHomePage(title: 'Flutter Demo Home Page'),
};

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Logger.log(TAG, message: 'is debug mode: ${AppConfig.IS_DEBUG}', isNeed: true);

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