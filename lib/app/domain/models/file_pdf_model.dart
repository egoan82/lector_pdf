import 'dart:convert';

FilePdf filePdfFromJson(String str) => FilePdf.fromJson(json.decode(str));

String filePdfToJson(FilePdf data) => json.encode(data.toJson());

class FilePdf {
  FilePdf({
    this.id,
    required this.name,
    required this.identifier,
    required this.size,
    required this.path,
    required this.date,
  });

  final int? id;
  final String name;
  final String identifier;
  final int size;
  final String path;
  final DateTime date;

  factory FilePdf.fromJson(Map<String, dynamic> json) => FilePdf(
        id: json["id"] ?? 0,
        name: json["name"] ?? 'Sin información',
        identifier: json["identifier"] ?? '',
        size: json["size"] ?? 0,
        path: json["path"] ?? '',
        date: json["date"] ?? DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        "id": 0,
        "name": name,
        "identifier": identifier,
        "size": size,
        "path": path,
        "date": date,
      };
}
