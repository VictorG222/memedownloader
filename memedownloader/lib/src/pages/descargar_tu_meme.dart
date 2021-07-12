import 'package:flutter/material.dart';
import 'package:memedownloader/src/models/url_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DescargarMeme extends StatefulWidget {
  @override
  _DescargarMemeState createState() => _DescargarMemeState();
}

class _DescargarMemeState extends State<DescargarMeme> {
  @override
  Widget build(BuildContext context) {
    final _mediaSize = MediaQuery.of(context).size;
    final URLModel meme =
        ModalRoute.of(context)!.settings.arguments as URLModel;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(204, 173, 102, 1.0),
        title: Text("Descarga tu meme"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            Image.network(
              meme.url.toString(),
              height: _mediaSize.height * 0.80,
            ),
            SizedBox(
              height: _mediaSize.height * 0.05,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(204, 173, 102, 1.0)),
              onPressed: () => _launchUrl(meme.url.toString()),
              child: Text('Descargar Meme'),
            )
          ],
        ),
      ),
    );
  }

  static Future _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
