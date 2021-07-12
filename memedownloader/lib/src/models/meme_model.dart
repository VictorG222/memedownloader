class MemeModel {
  String? id;
  String? name;
  String? image;
  int? width;
  int? height;
  int? boxes;

  MemeModel(
      {this.id, this.name, this.image, this.height, this.width, this.boxes});

  factory MemeModel.fromMapJson(Map<String, dynamic> memes) => MemeModel(
      id: memes['id'],
      name: memes['name'],
      image: memes['url'],
      width: memes['width'],
      height: memes['height'],
      boxes: memes['box_count']);
}
