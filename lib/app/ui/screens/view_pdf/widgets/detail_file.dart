import 'package:flutter/material.dart';

import '../../../../domain/models/file_pdf_model.dart';
import '../provider/view_pdf_provider.dart';

class DetailFile extends StatelessWidget {
  const DetailFile({
    Key? key,
    required this.file,
    required this.controller,
  }) : super(key: key);

  final FilePdf file;
  final ViewPdfProvider controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: const [
          Icon(
            Icons.description_outlined,
            color: Colors.red,
          ),
          SizedBox(width: 10),
          Text('Detalle del archivo')
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Título: ${controller.document.document.documentInformation.title}",
            ),
            Text(
              "Tamaño: " + "${(file.size / 1e+6)}".substring(0, 4) + " Mb",
            ),
            Text(
              "Total páginas: ${controller.document.document.pages.count}",
            ),
            const SizedBox(height: 6),
            Text(
              "Úbicacion: ${file.path}",
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}
