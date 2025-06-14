import 'package:flutter/material.dart';
import 'package:video_tape_store/models/video_tape.dart';
import 'package:video_tape_store/style/style.dart';

class FilmPage extends StatefulWidget {
  final VideoTape videoTape;
  static List<VideoTape> cart = [];

  const FilmPage({super.key, required this.videoTape});

  @override
  State<FilmPage> createState() => _FilmPageState();
}

class _FilmPageState extends State<FilmPage> {
  void addToCart(VideoTape videoTape) {
    setState(() {
      FilmPage.cart.add(videoTape);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${videoTape.Title} added to cart!')),
    );
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
                      "http://10.0.2.2:3000${widget.videoTape.VideoTapeImage}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(widget.videoTape.Title, style: AppTextStyle.title(context)),
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
                        'Genre: ${widget.videoTape.Genre}',
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
                        'Level: ${widget.videoTape.Level}',
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
                        'Price: ${widget.videoTape.Price}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                widget.videoTape.Description,
                style: AppTextStyle.body(context),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.red,
        ),
        child: TextButton(
          onPressed: () {
            addToCart(widget.videoTape);
          },
          style: TextButton.styleFrom(foregroundColor: Colors.white),
          child: const Text(
            "Add to Cart",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
