import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
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
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  String totalPages = '0';

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    _controller.dispose();
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
            ),
            body: Stack(
              children: [
                SfPdfViewer.file(
                  File(
                    file.path,
                  ),
                  onDocumentLoaded: (details) {
                    controller.totalPages = details.document.pages.count;
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
                Selector<ViewPdfProvider, int>(
                  selector: (_, c) => c.currentPage,
                  builder: (_, currentPage, __) {
                    if (currentPage > 1) {
                      return FadeTransition(
                        opacity: _animation,
                        child: Positioned(
                          bottom: 10,
                          right: 10,
                          child: InkWell(
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
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
