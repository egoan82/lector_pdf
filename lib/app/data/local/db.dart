import 'package:isar/isar.dart';

import '../../domain/collections/file_pdf_collection.dart';
import '../../domain/models/file_pdf_model.dart';

class DB {
  static final DB _instance = DB._internal();

  DB._internal();
  static DB get i => _instance;

  late Isar isar;

  void loadDB() async {
    isar = await Isar.open([FilePdfColletionSchema]);
  }

  Future<void> add(FilePdf file) async {
    final newFile = FilePdfColletion()
      ..name = file.name
      ..identifier = file.identifier
      ..path = file.path
      ..size = file.size;

    await isar.writeTxn(
      () async {
        await isar.filePdfColletions.put(newFile);
      },
    );
  }

  Future<List<FilePdfColletion>> getAll() async {
    final r = await isar.filePdfColletions.filter().nameIsNotEmpty().findAll();
    return r;
  }
}
