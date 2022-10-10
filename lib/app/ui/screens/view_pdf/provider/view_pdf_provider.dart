import 'package:flutter/cupertino.dart';

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
}
