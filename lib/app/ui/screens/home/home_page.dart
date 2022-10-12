import 'package:flutter/material.dart';
import 'package:open_as_default/open_as_default.dart';
import 'dart:io';

import 'package:provider/provider.dart';

import '../../../domain/models/file_pdf_model.dart';
import 'provider/home_provider.dart';
import 'widgets/button_search.dart';
import 'widgets/list_recents_files.dart';
import 'widgets/not_files_recents.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        loadIntent();
      },
    );
  }

  void loadIntent() async {
    if (Platform.isAndroid) {
      OpenAsDefault.getFileIntent.then((value) async {
        if (value != null) {
          final sizeFile = await value.length();
          final file = FilePdf(
            name: value.path.split('/').last,
            identifier: value.path.split('/').last,
            size: sizeFile,
            path: value.path,
            date: DateTime.now(),
          );

          final r = await Navigator.pushNamed(
            context,
            'viewpdf',
            arguments: file,
          );

          if (r != null || r == true) {
            Provider.of<HomeProvider>(
              _scaffoldKey.currentContext!,
              listen: false,
            ).getAll();
          }
        }
        // code
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<HomeProvider>(
      create: (context) => HomeProvider(),
      child: Consumer<HomeProvider>(
        builder: (_, controller, __) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: const Text('Lector PDF'),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: _scaffoldKey.currentContext!,
                      builder: (context) => AlertDialog(
                        title: Row(
                          children: const [
                            Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            SizedBox(width: 10),
                            Text('Borrar todo'),
                          ],
                        ),
                        content: const Text(
                          '¿Desea eliminar todos los registros de documentos abiertos?',
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          ElevatedButton(
                            child: const Text('Si, eliminar'),
                            onPressed: () async {
                              Navigator.of(_scaffoldKey.currentContext!,
                                      rootNavigator: true)
                                  .pop();

                              showDialog(
                                context: _scaffoldKey.currentContext!,
                                builder: (context) => AlertDialog(
                                  title: Row(
                                    children: const [
                                      Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      SizedBox(width: 10),
                                      Text('Eliminando...'),
                                    ],
                                  ),
                                  content: const SizedBox(
                                    height: 80,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                              );
                              await controller.deleteAll();
                              await Future.delayed(
                                const Duration(milliseconds: 800),
                                () => Navigator.of(_scaffoldKey.currentContext!,
                                        rootNavigator: true)
                                    .pop(),
                              );
                            },
                          ),
                          ElevatedButton(
                            child: const Text('Cancelar'),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.blueGrey,
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.sort_outlined),
                  onPressed: () {
                    controller.sortList = !controller.sortList;
                    controller.getAll(sort: controller.sortList);
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
                        ? NotFilesRecents(size: size)
                        : Expanded(
                            child: ListRecentsFiles(
                              listFiles: listFiles,
                            ),
                          );
                  },
                ),
              ],
            ),
            floatingActionButton: ButtonSearch(
              controller: controller,
            ),
          );
        },
      ),
    );
  }
}
