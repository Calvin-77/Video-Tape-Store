import 'package:flutter/material.dart';
import 'package:video_tape_store/models/video_tape.dart';
import 'package:video_tape_store/style/style.dart';
import 'package:video_tape_store/user_page/film_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BigBox extends StatelessWidget {
  final VideoTape videoTape;
  const BigBox({super.key, required this.videoTape});

  Future<Map<String, dynamic>> fetchMovieData() async {
    const url = "http://10.0.2.2:3000/videos/get";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;

      return data.isNotEmpty ? data[0] : {};
    } else {
      throw Exception('Failed to load movie data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FilmPage(videoTape: videoTape)),
        );
      },
      child: FutureBuilder<Map<String, dynamic>>(
        future: fetchMovieData(),
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (data != null) {
            return Stack(
              children: [
                Image.network(
                  "http://10.0.2.2:3000${videoTape.Image_landscape}",
                  fit: BoxFit.cover,
                  height: 280,
                ),
                Positioned(
                  height: 40,
                  bottom: 0,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration:
                        const BoxDecoration(color: Color.fromARGB(96, 9, 6, 6)),
                    child: Text(
                      videoTape.Title,
                      style: AppTextStyle.title(context),
                      textAlign: TextAlign.left,
                    ),
                  ),
                )
              ],
            );
          }
          return const Text("Loading..");
        },
      ),
    );
  }
}
