import 'dart:typed_data';

import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider() {
    print("HOME CONTROLLER CREATED");
  }
  String _action = '';
  String get action => _action;

  set action(String s) {
    _action = s;
    notifyListeners();
  }

  Uint8List _img = Uint8List.fromList([]);
  Uint8List get img => _img;

  set img(Uint8List s) {
    _img = s;
    notifyListeners();
  }

  String _file = '';
  String get file => _file;

  set file(String s) {
    _file = s;
    notifyListeners();
  }
}
