import 'package:flutter/material.dart';

class ChangeTabNotifier extends ChangeNotifier{
  int _currentTab = 0;
  int get currentTab => _currentTab;
  void setTab(index){
    _currentTab=index;
    notifyListeners();
  }
}
