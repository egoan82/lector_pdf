import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../provider/view_pdf_provider.dart';

class ButtonUp extends StatelessWidget {
  const ButtonUp({
    Key? key,
    required this.size,
    required PdfViewerController pdfViewerController,
  })  : _pdfViewerController = pdfViewerController,
        super(key: key);

  final Size size;
  final PdfViewerController _pdfViewerController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
    );
  }
}
