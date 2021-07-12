import 'package:dio/dio.dart';
import 'package:memedownloader/src/models/meme_model.dart';

class MemesProvider {
  final String _url = 'https://api.imgflip.com/get_memes';
  final http = Dio();

  Future<List<MemeModel>> obtenerMemes() async {
    final response = await http.get(_url);
    List<MemeModel> memes = [];
    List<dynamic> responseData = response.data['data']['memes'];

    for (int i = 0; i < responseData.length; i++) {
      memes.add((MemeModel.fromMapJson(responseData[i])));
    }
    return memes;
  }
}
