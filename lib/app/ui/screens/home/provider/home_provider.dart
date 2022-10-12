import 'package:flutter/material.dart';
import 'package:lector_pdf/app/data/local/db.dart';

import '../../../../domain/models/file_pdf_model.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider() {
    load();
  }

  void load() async {
    await DB.i.loadDB();
    if (DB.i.isOpenDB()) {
      await getAll();
    }
  }

  bool _sortList = true;
  bool get sortList => _sortList;

  set sortList(bool s) {
    _sortList = s;
    notifyListeners();
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

  Future<void> getAll({bool sort = true}) async {
    final list = await DB.i.getAll(sort: sort);

    List<FilePdf> l = [];

    if (list.isNotEmpty) {
      l = list
          .map(
            (e) => FilePdf(
              id: e.id,
              name: e.name,
              identifier: e.identifier,
              size: e.size,
              path: e.path,
              date: e.date,
            ),
          )
          .toList();
    }
    listFiles = l;
  }

  Future<FilePdf> getFile(int id) async {
    final file = await DB.i.getFile(id);

    final f = FilePdf(
      id: file.id,
      name: file.name,
      identifier: file.identifier,
      size: file.size,
      path: file.path,
      date: file.date,
    );

    return f;
  }

  Future<void> deleteFile(int id) async {
    await DB.i.deleteFile(id);
  }

  Future<void> deleteAll() async {
    await DB.i.deleteAll();
    await getAll();
  }
}
