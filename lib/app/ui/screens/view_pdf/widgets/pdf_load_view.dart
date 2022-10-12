import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../data/local/db.dart';
import '../../../../domain/models/file_pdf_model.dart';
import '../provider/view_pdf_provider.dart';

class PdfLoadView extends StatelessWidget {
  const PdfLoadView({
    Key? key,
    required this.file,
    required PdfViewerController pdfViewerController,
    required this.controller,
  })  : _pdfViewerController = pdfViewerController,
        super(key: key);

  final FilePdf file;
  final PdfViewerController _pdfViewerController;
  final ViewPdfProvider controller;

  @override
  Widget build(BuildContext context) {
    return SfPdfViewer.file(
      File(
        file.path,
      ),
      onDocumentLoaded: (details) async {
        controller.totalPages = details.document.pages.count;
        controller.document = details;
        await DB.i.add(file);
      },
      onPageChanged: (details) {
        controller.currentPage = details.newPageNumber;
      },
      onDocumentLoadFailed: (details) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: const [
              Icon(
                Icons.description_outlined,
                color: Colors.red,
              ),
              SizedBox(width: 10),
              Text('Error')
            ],
          ),
          content: const Text('No es posible abrir este archivo'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok'),
            ),
          ],
        ),
      ),
      controller: _pdfViewerController,
    );
  }
}
