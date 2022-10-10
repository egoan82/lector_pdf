import 'package:flutter/material.dart';

import 'app/ui/screens/home/home_page.dart';
import 'app/ui/screens/view_pdf/view_pdf.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      // home: const HomePage(),
      initialRoute: 'home',
      routes: {
        'home': (context) => const HomePage(),
        'viewpdf': (context) => const ViewPdf(),
      },
    );
  }
}
