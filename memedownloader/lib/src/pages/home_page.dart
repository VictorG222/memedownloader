import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memedownloader/src/models/meme_model.dart';
import 'package:memedownloader/src/provider/memes_state.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State {
  final _controller = ScrollController();
  bool _cargando = false;

  @override
  void initState() {
    final _memeState = Get.put(MemesState());
    _memeState.obtenerMemes();

    _controller.addListener(() async {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 280) {
        if (_cargando == false) {
          setState(() {
            _cargando = true;
          });
          await _memeState.obtenerMemes();
          setState(() {
            _cargando = false;
          });
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(204, 173, 102, 1.0),
        title: Center(
            child: Text(
          'Meme Downloader',
          style: TextStyle(fontSize: 30.0, color: Colors.black),
        )),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              )),
              child: _Memes(_controller),
            ),
            if (_cargando == true)
              Center(
                  child: CircularProgressIndicator(
                strokeWidth: 13.0,
                color: Color.fromRGBO(204, 173, 102, 1.0),
              ))
            else
              Container()
          ],
        ),
      ),
    );
  }
}

class _Memes extends StatelessWidget {
  final ScrollController controller;
  _Memes(this.controller);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MemesState>(builder: (MemesState memeState) {
      return GridView.builder(
        controller: controller,
        itemCount: memeState.meme.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, childAspectRatio: 1),
        itemBuilder: (BuildContext context, int i) {
          final meme = memeState.meme[i];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/crear', arguments: meme);
            },
            child: Container(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  _TargetaMeme(meme),
                  _ImagenMeme(meme),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

class _ImagenMeme extends StatelessWidget {
  final MemeModel _meme;
  _ImagenMeme(this._meme);
  @override
  Widget build(BuildContext context) {
    final _mediaSize = MediaQuery.of(context).size;
    return Center(
      child: Hero(
        tag: _meme.name!.toString(),
        child: FadeInImage(
          fit: BoxFit.cover,
          height: _mediaSize.height * 0.40,
          width: _mediaSize.width * 0.90,
          placeholder: AssetImage('assets/cargando.gif'),
          image: NetworkImage(_meme.image!.toString()),
        ),
      ),
    );
  }
}

class _TargetaMeme extends StatelessWidget {
  final MemeModel _meme;
  _TargetaMeme(this._meme);
  @override
  Widget build(BuildContext context) {
    final _mediaSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      width: double.infinity,
      height: _mediaSize.height * 0.80,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: Color.fromRGBO(255, 240, 204, 1.0),
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _meme.name!.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
