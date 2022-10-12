import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/file_pdf_model.dart';
import '../provider/home_provider.dart';

class ListRecentsFiles extends StatelessWidget {
  const ListRecentsFiles({
    Key? key,
    required this.listFiles,
  }) : super(key: key);

  final List<FilePdf> listFiles;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: listFiles.length,
        itemBuilder: (context, index) {
          final f = listFiles[index];
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              Provider.of<HomeProvider>(
                context,
                listen: false,
              ).deleteFile(f.id!);
            },
            secondaryBackground: Container(
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.delete,
                  size: size.height * 0.04,
                  color: Colors.white,
                ),
              ),
            ),
            background: Container(
              alignment: Alignment.centerLeft,
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.delete,
                  size: size.height * 0.04,
                  color: Colors.white,
                ),
              ),
            ),
            child: ListTile(
              title: Text(
                f.name,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Peso: " + "${(f.size / 1e+6)}".substring(0, 4) + " Mb"),
                  Text(
                    "Fecha: ${DateFormat('y-MM-dd hh:mm:ss a').format(f.date)}",
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Ruta: ${f.path}",
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              leading: const FaIcon(
                FontAwesomeIcons.filePdf,
                color: Colors.red,
              ),
              // trailing: const Icon(Icons.keyboard_arrow_right_outlined),
              onTap: () async {
                final file = await Provider.of<HomeProvider>(
                  context,
                  listen: false,
                ).getFile(f.id!);

                Navigator.pushNamed(context, 'viewpdf', arguments: file);
              },
            ),
          );
        },
      ),
    );
  }
}
