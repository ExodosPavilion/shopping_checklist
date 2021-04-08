import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_checklist/constants.dart';
import 'package:shopping_checklist/ui/checklist.dart';
import 'package:shopping_checklist/ui/history.dart';
import 'package:shopping_checklist/ui/itemGroup.dart';
import 'package:shopping_checklist/changeNotifiers/DrawerStateInfo.dart';
import 'package:shopping_checklist/ui/settings.dart';

//https://medium.com/flutter-community/flutter-vi-navigation-drawer-flutter-1-0-3a05e09b0db9

class AppDrawer extends StatelessWidget {
  AppDrawer(this.currentPage);

  final String currentPage;

  @override
  Widget build(BuildContext context) {
    int currentDrawer = Provider.of<DrawerStateInfo>(context).getCurrentDrawer;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(context),
          _createDrawerItem(
            icon: Icons.library_add_check,
            text: kChecklistScreen,
            position: 0,
            //https://dev.to/aaronksaunders/flutter-drawer-with-state-management-3g19
            onTap: () {
              Navigator.of(context).pop();
              if (this.currentPage == kChecklistScreen) return;

              Provider.of<DrawerStateInfo>(context, listen: false)
                  .setCurrentDrawer(0);

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => CheckList(),
                ),
              );
            },
            curDrawer: currentDrawer,
          ),
          _createDrawerItem(
            icon: Icons.list_alt,
            text: kPresetScreen,
            position: 1,
            //https://dev.to/aaronksaunders/flutter-drawer-with-state-management-3g19
            onTap: () {
              Navigator.of(context).pop();
              if (this.currentPage == kPresetAppDrawer) return;

              Provider.of<DrawerStateInfo>(context, listen: false)
                  .setCurrentDrawer(1);

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => ItemGroup(),
                ),
              );
            },
            curDrawer: currentDrawer,
          ),
          _createDrawerItem(
            icon: Icons.history,
            text: kHistoryScreen,
            position: 2,
            //https://dev.to/aaronksaunders/flutter-drawer-with-state-management-3g19
            onTap: () {
              Navigator.of(context).pop();
              if (this.currentPage == kHistoryScreen) return;

              Provider.of<DrawerStateInfo>(context, listen: false)
                  .setCurrentDrawer(2);

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => History(),
                ),
              );
            },
            curDrawer: currentDrawer,
          ),
          _createDrawerItem(
            icon: Icons.settings,
            text: kSettingsScreen,
            position: 3,
            //https://dev.to/aaronksaunders/flutter-drawer-with-state-management-3g19
            onTap: () {
              Navigator.of(context).pop();
              if (this.currentPage == kSettingsScreen) return;

              Provider.of<DrawerStateInfo>(context, listen: false)
                  .setCurrentDrawer(3);

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => Settings(),
                ),
              );
            },
            curDrawer: currentDrawer,
          ),
        ],
      ),
    );
  }

  Widget _createHeader(BuildContext context) {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.blue,
        gradient: new LinearGradient(
          colors: [
            Colors.blue,
            Theme.of(context).backgroundColor,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text(
              kAppName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData icon,
      String text,
      GestureTapCallback onTap,
      int position,
      int curDrawer}) {
    return ListTile(
      leading: Icon(
        icon,
        color: curDrawer == position ? Colors.blue : Colors.grey,
      ),
      title: Text(
        text,
        style: curDrawer == position
            ? TextStyle(fontWeight: FontWeight.bold)
            : TextStyle(fontWeight: FontWeight.normal),
      ),
      trailing: Icon(
        Icons.arrow_forward,
        color: curDrawer == position ? Colors.blue : Colors.grey,
      ),
      onTap: onTap,
    );
  }
}
