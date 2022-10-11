import 'package:isar/isar.dart';

part 'file_pdf_collection.g.dart';

@Collection()
class FilePdfColletion {
  @Index()
  Id id = Isar.autoIncrement;
  late String name;
  late String identifier;
  late int size;
  late String path;
}
