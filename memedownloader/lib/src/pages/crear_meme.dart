import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:memedownloader/src/models/meme_model.dart';
import 'package:memedownloader/src/models/url_model.dart';

class CrearMeme extends StatefulWidget {
  @override
  _MemeCrearState createState() => _MemeCrearState();
}

class _MemeCrearState extends State<CrearMeme> {
  final primeraLinea = TextEditingController();
  final segundaLinea = TextEditingController();

  void enviarMeme(
      String id, String url, String primeraLinea, String segundaLinea) async {
    final String template_id = id;
    final String username = 'Warrior222';
    final String password = 'apiparalaapp';
    final String text0 = primeraLinea;
    final String text1 = segundaLinea;

    var response = await Dio().get(
        'https://api.imgflip.com/caption_image?template_id=$template_id&text0=$text0&text1=$text1&username=$username&password=$password');

    if (response.statusCode == 200) {
      final MemeModel meme =
          ModalRoute.of(context)!.settings.arguments as MemeModel;
      print(response.data['data']['url']);
      Navigator.pushNamed(
        context,
        '/descargar',
        arguments: URLModel(response.data['data']['url'], meme.id.toString()),
      );
    } else {
      throw Exception('Fallo en la carga de memes');
    }
  }

  @override
  Widget build(BuildContext context) {
    final _mediaSize = MediaQuery.of(context).size;
    final MemeModel meme =
        ModalRoute.of(context)!.settings.arguments as MemeModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          meme.name!.toString(),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(204, 173, 102, 1.0),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/background.png'),
          fit: BoxFit.cover,
        )),
        child: ListView(
          children: [
            _ImagenMeme(meme),
            _CaracteristicasMeme(meme),
            SizedBox(
              height: _mediaSize.height * 0.1,
            ),
            Column(
              children: <Widget>[
                TextField(
                  controller: primeraLinea,
                  decoration: InputDecoration(labelText: 'Texto 1'),
                ),
                SizedBox(
                  height: _mediaSize.height * 0.05,
                ),
                TextField(
                  controller: segundaLinea,
                  decoration: InputDecoration(labelText: 'Texto 2'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(204, 173, 102, 1.0),
        onPressed: () {
          enviarMeme(
            meme.id!.toString(),
            meme.image!.toString(),
            primeraLinea.text,
            segundaLinea.text,
          );
        },
        child: Icon(Icons.check),
      ),
    );
  }
}

class _ImagenMeme extends StatelessWidget {
  final MemeModel meme;
  _ImagenMeme(this.meme);
  @override
  Widget build(BuildContext context) {
    final _mediaSize = MediaQuery.of(context).size;
    return Container(
      child: SizedBox(
          height: _mediaSize.height * 0.80, child: Image.network(meme.image!)),
    );
  }
}

class _CaracteristicasMeme extends StatelessWidget {
  final MemeModel meme;
  _CaracteristicasMeme(this.meme);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Text(
          'Width     Height',
          style: TextStyle(fontSize: 30, color: Colors.white),
        )),
        Center(
          child: Text(
            '${meme.width}px x ${meme.height}px',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ],
    );
  }
}
