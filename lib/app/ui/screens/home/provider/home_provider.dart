import 'package:flutter/material.dart';
import 'package:lector_pdf/app/data/local/db.dart';

import '../../../../domain/models/file_pdf_model.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider() {
    load();
  }

  void load() async {
    DB.i.loadDB();
  }

  List<FilePdf> _listFiles = [];
  List<FilePdf> get listFiles => _listFiles;

  set listFiles(List<FilePdf> f) {
    _listFiles = f;
    notifyListeners();
  }

  Future<void> add(FilePdf file) async {
    await DB.i.add(file);
  }

  Future<void> getAll() async {
    final list = await DB.i.getAll();

    if (list.isNotEmpty) {
      final l = list
          .map(
            (e) => FilePdf(
              name: e.name,
              identifier: e.identifier,
              size: e.size,
              path: e.path,
            ),
          )
          .toList();

      listFiles = l;
    }
  }
}
