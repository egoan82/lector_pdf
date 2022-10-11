import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';

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
                    }
                  },
                ),
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Selector<HomeProvider, List<FilePdf>>(
                  selector: (_, c) => c.listFiles,
                  builder: (context, listFiles, child) {
                    return (listFiles.isEmpty)
                        ? Column(
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
                          )
                        : Expanded(
                            child: ListView.builder(
                            itemCount: listFiles.length,
                            itemBuilder: (context, index) {
                              final f = listFiles[index];
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ListTile(
                                  title: Text(f.name),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Peso: ${f.size}"),
                                      Text("Ruta: ${f.path}"),
                                    ],
                                  ),
                                  leading: const FaIcon(
                                    FontAwesomeIcons.filePdf,
                                    color: Colors.red,
                                  ),
                                  trailing: const Icon(
                                      Icons.keyboard_arrow_right_outlined),
                                  onTap: () {},
                                ),
                              );
                            },
                          ));
                  },
                ),
              ],
            ),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    controller.getAll();
                  },
                  child: const Icon(Icons.search),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: () {
                    controller.add(
                      FilePdf(
                        name: 'Isar Manual',
                        identifier: '1234',
                        size: 240,
                        path: 'Descargas',
                      ),
                    );
                  },
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
