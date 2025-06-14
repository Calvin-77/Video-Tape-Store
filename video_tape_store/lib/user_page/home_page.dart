import 'package:flutter/material.dart' hide CarouselController;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_tape_store/models/video_tape.dart';
import 'package:video_tape_store/user_page/cart_page.dart';
import 'package:video_tape_store/widgets/big_box.dart';
import 'package:video_tape_store/widgets/genre_box.dart';
import 'package:video_tape_store/widgets/movie_box.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final List<String> genreList = [
    'Animation',
    'Action',
    'Horror',
    'Comedy',
    'Romance',
    'Adventure'
  ];

  HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late Future<List<VideoTape>> videoTapeList;
  List<bool> isSelected = [];
  String selectedGenre = 'Animation';

  @override
  void initState() {
    super.initState();
    videoTapeList = fetchVideoTape();
    isSelected = List.generate(widget.genreList.length, (index) => index == 0);
  }

  Future<List<VideoTape>> fetchVideoTape() async {
    String url = "http://10.0.2.2:3000/videos/get";
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      var result = jsonDecode(res.body);
      print(result);

      List<VideoTape> videoTapes = [];
      for (var i in result) {
        VideoTape fetchVideoTape = VideoTape.fromJson(i);
        videoTapes.add(fetchVideoTape);
      }
      return videoTapes;
    } else {
      throw Exception('Failed to load video tapes');
    }
  }

  Future<List<VideoTape>> fetchFilteredVideoTapes(String genre) async {
    final VideoTape = await fetchVideoTape();
    return VideoTape.where((tape) => tape.Genre == genre).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                      child: FutureBuilder<List<VideoTape>>(
                        future: videoTapeList,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return CarouselSlider.builder(
                              itemCount: snapshot.data!.length,
                              options: CarouselOptions(
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 3),
                                enlargeCenterPage: true,
                                viewportFraction: 0.8,
                              ),
                              itemBuilder: (context, index, realIndex) {
                                return BigBox(videoTape: snapshot.data![index]);
                              },
                            );
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ToggleButtons(
                        renderBorder: false,
                        isSelected: isSelected,
                        onPressed: (int index) {
                          setState(() {
                            for (int i = 0; i < isSelected.length; i++) {
                              isSelected[i] = (i == index);
                            }
                            selectedGenre = widget.genreList[index];
                          });
                        },
                        fillColor: Colors.transparent,
                        selectedColor: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        children: List.generate(
                          widget.genreList.length,
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GenreBox(
                                genre: widget.genreList[index],
                                isSelected: isSelected[index],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: (MediaQuery.of(context).size.height * 0.6) - 100,
                      child: FutureBuilder<List<VideoTape>>(
                        future: videoTapeList,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var filteredMovies = snapshot.data!
                                .where((tape) => tape.Genre == selectedGenre)
                                .toList();

                            return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2 / 3,
                              ),
                              itemCount: filteredMovies.length,
                              itemBuilder: (context, index) {
                                return MovieBox(
                                    videoTape: filteredMovies[index]);
                              },
                            );
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: IconButton(
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Cart()),
                      );
                    },
                    icon: Icon(
                      PhosphorIcons.shoppingCartSimple(
                          PhosphorIconsStyle.regular),
                      size: 32.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
