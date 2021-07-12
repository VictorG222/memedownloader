import 'package:get/get.dart';
import 'package:memedownloader/src/models/meme_model.dart';
import 'package:memedownloader/src/provider/memes_provider.dart';

class MemesState extends GetxController {
  List<MemeModel> meme = [];
  final _memesProvider = MemesProvider();

  Future<void> obtenerMemes() async {
    final memes = await _memesProvider.obtenerMemes();
    meme.addAll(memes);
    update();
  }
}
