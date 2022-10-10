import 'package:flutter/material.dart';

import '../../../../domain/models/file_pdf_model.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider() {
    load();
  }

  void load() async {}

  String _action = '';
  String get action => _action;

  set action(String s) {
    _action = s;
    notifyListeners();
  }

  Future<void> add(FilePdf file) async {}

  Future<void> getAll() async {}
}
