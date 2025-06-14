class VideoTape {
  int VideoTapeID;
  String Title;
  int Price;
  String Description;
  String Genre;
  String Level;
  String VideoTapeImage;
  String? Image_landscape;

  VideoTape(
      {required this.VideoTapeID,
      required this.Title,
      required this.Price,
      required this.Description,
      required this.Genre,
      required this.Level,
      required this.VideoTapeImage,
      this.Image_landscape = ''});

  factory VideoTape.fromJson(Map<String, dynamic> json) => VideoTape(
      VideoTapeID: json["VideoTapeID"] as int,
      Title: json["Title"].toString(),
      Price: json["Price"] as int,
      Description: json["Description"].toString(),
      Genre: json["Genre"].toString(),
      Level: json["Level"].toString(),
      VideoTapeImage: json["VideoTapeImage"].toString(),
      Image_landscape: json["Image_landscape"]?.toString() ?? '');
}
