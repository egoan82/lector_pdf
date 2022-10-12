import 'package:flutter/material.dart';

class NotFilesRecents extends StatelessWidget {
  const NotFilesRecents({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
