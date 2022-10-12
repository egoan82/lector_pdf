import 'package:flutter/material.dart';

import '../provider/view_pdf_provider.dart';

class DetailTotalPages extends StatelessWidget {
  const DetailTotalPages({
    Key? key,
    required this.size,
    required this.controller,
  }) : super(key: key);

  final Size size;
  final ViewPdfProvider controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
    );
  }
}
