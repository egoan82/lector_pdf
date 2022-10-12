// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../domain/models/file_pdf_model.dart';
import '../home/provider/home_provider.dart';
import 'provider/view_pdf_provider.dart';
import 'widgets/button_up.dart';
import 'widgets/detail_file.dart';
import 'widgets/detail_total_pages.dart';
import 'widgets/pdf_load_view.dart';

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
      child: Builder(
        builder: (context) => WillPopScope(
          onWillPop: () async {
            Navigator.pop(context, true);
            return true;
          },
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
                              builder: (context) => DetailFile(
                                file: file,
                                controller: controller,
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
                    PdfLoadView(
                      file: file,
                      pdfViewerController: _pdfViewerController,
                      controller: controller,
                    ),
                    DetailTotalPages(
                      size: size,
                      controller: controller,
                    ),
                    ButtonUp(
                      size: size,
                      pdfViewerController: _pdfViewerController,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
