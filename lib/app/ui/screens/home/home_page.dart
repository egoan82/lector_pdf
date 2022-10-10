import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../domain/models/file_pdf_model.dart';
import 'provider/home_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<HomeProvider>(
      create: (context) => HomeProvider(),
      child: Consumer<HomeProvider>(
        builder: (_, controller, __) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Lector PDF'),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.search,
                  ),
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf'],
                    );

                    if (result != null) {
                      final file = FilePdf(
                        name: result.files.single.name,
                        identifier: result.files.single.identifier ?? '',
                        size: result.files.single.size,
                        path: result.files.single.path ?? '',
                      );

                      Navigator.pushNamed(context, 'viewpdf', arguments: file);
                    } else {
                      controller.action = '';
                      controller.file = '';
                    }
                  },
                ),
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Selector<HomeProvider, String>(
                  selector: (_, c) => c.action,
                  builder: (context, action, child) {
                    if (action.isEmpty) {
                      return Column(
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/no_data.png',
                              height: size.height * 0.2,
                            ),
                          ),
                          const Center(
                            child: Text(
                              'No hay archivos recientes',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          SizedBox(height: size.height * 0.1),
                        ],
                      );
                    }

                    return Center(
                      child: SizedBox(
                        height: size.height * 0.5,
                        width: size.width * 0.8,
                        child: SfPdfViewer.file(
                          File(
                            Provider.of<HomeProvider>(
                              context,
                              listen: false,
                            ).file,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
