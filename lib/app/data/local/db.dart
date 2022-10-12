import 'package:isar/isar.dart';

import '../../domain/collections/file_pdf_collection.dart';
import '../../domain/models/file_pdf_model.dart';

class DB {
  static final DB _instance = DB._internal();

  DB._internal();
  static DB get i => _instance;

  late Isar isar;

  Future<void> loadDB() async {
    isar = await Isar.open([FilePdfColletionSchema]);
  }

  bool isOpenDB() {
    final state = isar.isOpen;
    return state;
  }

  Future<void> add(FilePdf file) async {
    final newFile = FilePdfColletion()
      ..name = file.name
      ..identifier = file.identifier
      ..path = file.path
      ..size = file.size
      ..date = file.date;

    await isar.writeTxn(
      () async {
        await isar.filePdfColletions.put(newFile);
      },
    );
  }

  Future<List<FilePdfColletion>> getAll({bool sort = true}) async {
    final List<FilePdfColletion> r;
    if (sort) {
      r = await isar.filePdfColletions
          .filter()
          .nameIsNotEmpty()
          .sortByDateDesc()
          .findAll();
    } else {
      r = await isar.filePdfColletions
          .filter()
          .nameIsNotEmpty()
          .sortByDate()
          .findAll();
    }

    return r;
  }

  Future<FilePdfColletion> getFile(int id) async {
    final r = await isar.filePdfColletions.get(id);
    return r!;
  }

  Future<bool> deleteFile(int id) async {
    final r = await isar.writeTxn(
      () async {
        await isar.filePdfColletions.delete(id);
      },
    );
    return true;
  }
}
