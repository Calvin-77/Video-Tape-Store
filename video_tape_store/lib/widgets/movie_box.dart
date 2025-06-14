import 'package:flutter/material.dart';
import 'package:video_tape_store/models/video_tape.dart';
import 'package:video_tape_store/style/style.dart';
import 'package:video_tape_store/user_page/film_page.dart';

class MovieBox extends StatelessWidget {
  final VideoTape videoTape;
  const MovieBox({super.key, required this.videoTape});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FilmPage(
                      videoTape: videoTape,
                    )),
          );
        },
        child: SizedBox(
          child: Column(children: [
            SizedBox(
              height: 258,
              width: 258 * 2 / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  "http://10.0.2.2:3000${videoTape.VideoTapeImage}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Center(
              child: Text(
                videoTape.Title,
                style: AppTextStyle.body(context),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
