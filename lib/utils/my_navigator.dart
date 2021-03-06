import 'package:flutter/material.dart';
import 'package:flutter_ui_template/res/config/app_config.dart';
import 'package:flutter_ui_template/generated/i18n.dart';

import 'package:flutter_ui_template/pages/home/home_screen.dart';
import 'package:flutter_ui_template/pages/bottom_navigation/bottom_navigation_screen.dart';
import 'package:flutter_ui_template/pages/drawer_navigation/drawer_navigation_screen.dart';
import 'package:flutter_ui_template/pages/tab_bar/tab_bar_screen.dart';
import 'package:flutter_ui_template/pages/timeline/timeline_screen.dart';
import 'package:flutter_ui_template/pages/my_schedule/my_schedule_screen.dart';
import 'package:flutter_ui_template/pages/flight_search/flight_search_screen.dart';
import 'package:flutter_ui_template/pages/wallet/wallet_screen.dart';

class MyNavigator {
  static const String _HOME_SCREEN = "/home";
  static const String _BOTTOM_NAVIGATION_SCREEN = "/bottom_navigation";
  static const String _DRAWER_NAVIGATION_SCREEN = "/drawer_navigation";
  static const String _TAP_BAR_SCREEN = "/tap_bar";

  /// UI Challenge

  // Timeline
  static const String _TIMELINE_SCREEN = "/timeline";
  // MySchedule
  static const String _MY_SCHEDULE = "/my_schedule";
  // Flight search
  static const String _Flight_Search = "/flight_search";
  // Wallet
  static const String _Wallet = "/wallet";

  static void goToHome(BuildContext context) {
    Navigator.pushNamed(context, _HOME_SCREEN);
  }

  static void goToBottomNavigation(BuildContext context) {
    Navigator.pushNamed(context, _BOTTOM_NAVIGATION_SCREEN);
  }

  static void goToDrawerNavigation(BuildContext context) {
    Navigator.pushNamed(context, _DRAWER_NAVIGATION_SCREEN);
  }

  static void goToTabBar(BuildContext context) {
    Navigator.pushNamed(context, _TAP_BAR_SCREEN);
  }

  static void goToTimeline(BuildContext context) {
    Navigator.pushNamed(context, _TIMELINE_SCREEN);
  }

  static void goToMySchedule(BuildContext context) {
    Navigator.pushNamed(context, _MY_SCHEDULE);
  }

  static void goToFlightSearch(BuildContext context) {
    Navigator.pushNamed(context, _Flight_Search);
  }

  static void goToWallet(BuildContext context) {
    Navigator.pushNamed(context, _Wallet);
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
  },

  MyNavigator._TAP_BAR_SCREEN: (BuildContext context) {
    return TabBarScreen();
  },

  MyNavigator._TIMELINE_SCREEN: (BuildContext context) {
    return TimelineScreen();
  },

  MyNavigator._MY_SCHEDULE: (BuildContext context) {
    return MyScheduleScreen();
  },

  MyNavigator._Flight_Search: (BuildContext context) {
    return FlightSearchScreen();
  },

  MyNavigator._Wallet: (BuildContext context) {
    return WalletScreen();
  }
};