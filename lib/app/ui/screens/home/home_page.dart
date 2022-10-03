import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lector PDF'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {},
          ),
        ],
      ),
      body: ChangeNotifierProvider<HomeProvider>(
        create: (context) => HomeProvider(),
        child: Consumer<HomeProvider>(
          builder: (_, controller, __) {
            return Column(
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

                    if (action == 'img') {
                      return Center(
                        child: Image.memory(
                          Provider.of<HomeProvider>(
                            context,
                            listen: false,
                          ).img,
                          height: size.height * 0.4,
                        ),
                      );
                    }

                    if (action == 'pdflocal') {
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
                    }

                    return Center(
                      child: SizedBox(
                        height: size.height * 0.5,
                        width: size.width * 0.8,
                        child: SfPdfViewer.network(
                          Provider.of<HomeProvider>(
                            context,
                            listen: false,
                          ).file,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: size.height * 0.01),
                ElevatedButton(
                  child: const Text('Buscar imagenes local'),
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['png', 'jpg', 'jpeg'],
                    );

                    if (result != null) {
                      File file = File(result.files.single.path ?? '');

                      controller.img = await file.readAsBytes();
                      controller.action = 'img';
                    } else {
                      controller.action = '';
                      controller.img = Uint8List.fromList([]);
                    }
                  },
                ),
                ElevatedButton(
                  child: const Text('Buscar pdf online'),
                  onPressed: () async {
                    const String p =
                        'https://josejuansanchez.org/bd/unidad-04-sqlite/index.pdf';

                    controller.file = p;
                    controller.action = 'pdf';
                  },
                ),
                ElevatedButton(
                  child: const Text('Buscar archivo local'),
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf'],
                    );

                    if (result != null) {
                      File file = File(result.files.single.path ?? '');
                      controller.file = file.path;
                      controller.action = 'pdflocal';
                    } else {
                      controller.action = '';
                      controller.file = '';
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
