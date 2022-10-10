import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewPdfProvider with ChangeNotifier {
  int _totalPages = 0;
  int get totalPages => _totalPages;

  set totalPages(int t) {
    _totalPages = t;
    notifyListeners();
  }

  int _currentPage = 1;
  int get currentPage => _currentPage;

  set currentPage(int t) {
    _currentPage = t;
    notifyListeners();
  }

  late PdfDocumentLoadedDetails _document;
  PdfDocumentLoadedDetails get document => _document;

  set document(PdfDocumentLoadedDetails t) {
    _document = t;
    notifyListeners();
  }
}
