import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../domain/models/file_pdf_model.dart';
import 'provider/view_pdf_provider.dart';

class ViewPdf extends StatefulWidget {
  const ViewPdf({Key? key}) : super(key: key);

  @override
  State<ViewPdf> createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> with TickerProviderStateMixin {
  late PdfViewerController _pdfViewerController;

  String totalPages = '0';

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final file = ModalRoute.of(context)!.settings.arguments as FilePdf;

    return ChangeNotifierProvider<ViewPdfProvider>(
      create: (context) => ViewPdfProvider(),
      child: Consumer<ViewPdfProvider>(
        builder: (_, controller, __) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                file.name,
                overflow: TextOverflow.ellipsis,
              ),
              centerTitle: true,
              actions: [
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'detail',
                      child: const Text('Detalle'),
                      onTap: () async {
                        await Future.delayed(
                          const Duration(milliseconds: 300),
                        );
                        return showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
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
                                    "Tamaño: " +
                                        "${(file.size / 1e+6)}"
                                            .substring(0, 4) +
                                        " Mb",
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
                                child: const Text('Ok'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    PopupMenuItem(
                      value: 'share',
                      child: const Text('Compartir'),
                      onTap: () {
                        Share.shareFiles(
                          [file.path],
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            body: Stack(
              children: [
                SfPdfViewer.file(
                  File(
                    file.path,
                  ),
                  onDocumentLoaded: (details) {
                    controller.totalPages = details.document.pages.count;
                    controller.document = details;
                  },
                  onPageChanged: (details) {
                    controller.currentPage = details.newPageNumber;
                  },
                  controller: _pdfViewerController,
                ),
                Positioned(
                  bottom: 10,
                  left: size.width * 0.36,
                  child: Container(
                    height: size.height * 0.04,
                    width: size.width * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        "Página ${controller.currentPage.toString()}/${controller.totalPages.toString()}",
                        style: const TextStyle(
                          color: Colors.white60,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Selector<ViewPdfProvider, int>(
                    selector: (_, c) => c.currentPage,
                    builder: (_, currentPage, __) {
                      if (currentPage > 1) {
                        return InkWell(
                          child: Container(
                            height: size.height * 0.04,
                            width: size.width * 0.1,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.keyboard_arrow_up_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onTap: () {
                            _pdfViewerController.jumpToPage(1);
                          },
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
