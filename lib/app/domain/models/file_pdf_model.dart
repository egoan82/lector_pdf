import 'dart:convert';

FilePdf filePdfFromJson(String str) => FilePdf.fromJson(json.decode(str));

String filePdfToJson(FilePdf data) => json.encode(data.toJson());

class FilePdf {
  FilePdf({
    required this.name,
    required this.identifier,
    required this.size,
    required this.path,
  });

  final String name;
  final String identifier;
  final int size;
  final String path;

  factory FilePdf.fromJson(Map<String, dynamic> json) => FilePdf(
        name: json["name"] ?? 'Sin información',
        identifier: json["identifier"] ?? '',
        size: json["size"] ?? 0,
        path: json["path"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "identifier": identifier,
        "size": size,
        "path": path,
      };
}
