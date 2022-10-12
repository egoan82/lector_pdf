import 'package:flutter/material.dart';

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
                  icon: const Icon(Icons.sort_outlined),
                  onPressed: () {
                    controller.sortList = !controller.sortList;
                    controller.getAll(sort: controller.sortList);
                  },
                ),
                ButtonSearch(
                  controller: controller,
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
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: 'get',
                  onPressed: () {
                    controller.getAll();
                  },
                  child: const Icon(Icons.search),
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}
