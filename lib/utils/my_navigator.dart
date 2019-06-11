import 'package:flutter/material.dart';
import 'package:flutter_ui_template/res/config/app_config.dart';
import 'package:flutter_ui_template/generated/i18n.dart';

import 'package:flutter_ui_template/pages/home/home_screen.dart';
import 'package:flutter_ui_template/pages/bottom_navigation/bottom_navigation_screen.dart';
import 'package:flutter_ui_template/pages/drawer_navigation/drawer_navigation_screen.dart';

class MyNavigator {
  static const String _HOME_SCREEN = "/home";
  static const String _BOTTOM_NAVIGATION_SCREEN = "/bottom_navigation";
  static const String _DRAWER_NAVIGATION_SCREEN = "/drawer_navigation";
  static const String _TAP_BAR_SCREEN = "/tap_bar";

  static void goToHome(BuildContext context) {
    Navigator.pushNamed(context, _HOME_SCREEN);
  }

  static void goToBottomNavigation(BuildContext context) {
    Navigator.pushNamed(context, _BOTTOM_NAVIGATION_SCREEN);
  }

  static void goToDrawerNavigation(BuildContext context) {
    Navigator.pushNamed(context, _DRAWER_NAVIGATION_SCREEN);
  }
}

var routes = <String, WidgetBuilder>{
  MyNavigator._HOME_SCREEN: (BuildContext context) {
    if (AppConfig.IS_ENABLE_SPLASH)
      return MyHomePage(title: S.of(context).title);
    else {
      return MyHomePage(title: const S().title);
    }
  },

  MyNavigator._BOTTOM_NAVIGATION_SCREEN: (BuildContext context) {
    return BottomNavigationScreen(title: S.of(context).bottom_nav_title);
  },

  MyNavigator._DRAWER_NAVIGATION_SCREEN: (BuildContext context) {
    return DrawerNavigationScreen(title: S.of(context).drawer_nav_title);
  }
};