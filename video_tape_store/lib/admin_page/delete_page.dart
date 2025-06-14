import 'package:flutter/material.dart';
import 'package:video_tape_store/admin_page/home_page.dart';
import 'package:video_tape_store/admin_page/update_page.dart';
import 'package:video_tape_store/style/style.dart';
import 'package:video_tape_store/models/video_tape.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Delete extends StatelessWidget {
  final VideoTape videoTape;
  const Delete({super.key, required this.videoTape});

  void DeletePressed(BuildContext context, VideoTapeID) async {
    String url = "http://10.0.2.2:3000/videos/delete";

    var resp = await http.delete(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"VideoTapeID": videoTape.VideoTapeID}));

    if (resp.statusCode == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed to delete data: ${resp.reasonPhrase}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 40,
        iconTheme: const IconThemeData(color: Color(0xFF0075D4)),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 500,
              height: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "http://10.0.2.2:3000${videoTape.VideoTapeImage}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(videoTape.Title, style: AppTextStyle.title(context)),
            Container(
                padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        'Genre: ${videoTape.Genre}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        'Level: ${videoTape.Level}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        'Price: ${videoTape.Price}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                videoTape.Description,
                style: AppTextStyle.body(context),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 180,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Update(videoTape: videoTape),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Colors.red, width: 2),
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        'Update',
                        style: AppTextStyle.title(context),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 180,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () =>
                          DeletePressed(context, videoTape.VideoTapeID),
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Colors.red, width: 2),
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        'Delete',
                        style: AppTextStyle.title(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
