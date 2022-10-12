import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../domain/models/file_pdf_model.dart';
import '../provider/home_provider.dart';

class ButtonSearch extends StatelessWidget {
  const ButtonSearch({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeProvider controller;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.search,
      ),
      onPressed: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
        );

        if (result != null) {
          final file = FilePdf(
            name: result.files.single.name,
            identifier: result.files.single.identifier ?? '',
            size: result.files.single.size,
            path: result.files.single.path ?? '',
            date: DateTime.now(),
          );

          final r =
              await Navigator.pushNamed(context, 'viewpdf', arguments: file);

          if (r != null || r == true) {
            controller.getAll();
          }
        }
      },
    );
  }
}
