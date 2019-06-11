import 'package:flutter/material.dart';
import 'package:flutter_ui_template/utils/logger.dart';
import 'package:flutter_ui_template/generated/i18n.dart';
import 'package:flutter_ui_template/res/config/assets.dart';

class DrawerNavigationScreen extends StatefulWidget {
  DrawerNavigationScreen({Key key, String this.title}): super(key: key);
  final String title;

  @override
  _DrawerNavigationScreenState createState() => _DrawerNavigationScreenState();
}

class _DrawerNavigationScreenState extends State<DrawerNavigationScreen> {

  ThemeData _themeData = ThemeData(
    primarySwatch: Colors.blue,
  );

  @override
  Widget build(BuildContext context) {
    return Theme(
      isMaterialAppTheme: true,
      data: _themeData,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              // drawer header
              UserAccountsDrawerHeader(
                accountName: Text("Tsung Hsuan"),
                accountEmail: Text("tzongshiuan@gmail.com"),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage(Assets.lakeImage),
                    fit: BoxFit.cover,
                  )
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: ExactAssetImage(Assets.candidPhotoImage),
                ),
              ),
              // drawer items
              ListTile(
                leading: Icon(Icons.library_music),
                title: Text("Music"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              new ListTile(
                  leading: Icon(Icons.movie),
                  title: new Text("Movies"),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              new ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: new Text("Shopping"),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              new ListTile(
                  leading: Icon(Icons.apps),
                  title: new Text("Apps"),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              new ListTile(
                  leading: Icon(Icons.dashboard),
                  title: new Text("Docs"),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              new ListTile(
                  leading: Icon(Icons.settings),
                  title: new Text("Settings"),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              new Divider(),
              new ListTile(
                  leading: Icon(Icons.info),
                  title: new Text("About"),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              new ListTile(
                  leading: Icon(Icons.power_settings_new),
                  title: new Text("Logout"),
                  onTap: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}