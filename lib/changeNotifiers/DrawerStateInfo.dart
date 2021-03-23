import 'package:flutter/widgets.dart';

//courtesy of:
//https://dev.to/aaronksaunders/flutter-drawer-with-state-management-3g19
class DrawerStateInfo with ChangeNotifier {
  int _currentDrawer = 0;
  int get getCurrentDrawer => _currentDrawer;

  void setCurrentDrawer(int drawer) {
    _currentDrawer = drawer;
    notifyListeners();
  }

  void increment() {
    notifyListeners();
  }
}
