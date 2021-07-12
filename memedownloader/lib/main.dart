import 'package:flutter/material.dart';
import 'package:memedownloader/src/pages/descargar_tu_meme.dart';
import 'package:memedownloader/src/pages/home_page.dart';
import 'package:memedownloader/src/pages/crear_meme.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meme Downloader',
      initialRoute: '/',
      routes: {
        '/': (_) => HomePage(),
        '/crear': (_) => CrearMeme(),
        '/descargar': (_) => DescargarMeme(),
      },
    );
  }
}
