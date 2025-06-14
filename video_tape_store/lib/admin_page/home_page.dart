import 'package:flutter/material.dart';
import 'package:video_tape_store/admin_page/delete_page.dart';
import 'package:video_tape_store/admin_page/insert_page.dart';
import 'package:video_tape_store/screens/login_register_page.dart';
import 'package:video_tape_store/style/style.dart';
import 'package:video_tape_store/models/video_tape.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<VideoTape>> VideoTapeList;

  Future<List<VideoTape>> fetchVideoTape() async {
    String url = "http://10.0.2.2:3000/videos/get";

    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      var result = jsonDecode(res.body);
      print(result);

      List<VideoTape> videoTapeList = [];

      for (var i in result) {
        VideoTape fetchVideoTape = VideoTape.fromJson(i);
        videoTapeList.add(fetchVideoTape);
      }

      return videoTapeList;
    } else {
      throw Exception('Gagal memuat video tape');
    }
  }

  @override
  void initState() {
    super.initState();
    VideoTapeList = fetchVideoTape();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('SeNless SoNe zero'),
        titleTextStyle: AppTextStyle.title(context),
        backgroundColor: Theme.of(context).colorScheme.surface,
        toolbarHeight: 80,
        actions: [
          IconButton(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Insert()));
            },
            color: Colors.red,
            iconSize: 30,
          ),
          IconButton(
            padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
            icon: Icon(PhosphorIcons.signOut(PhosphorIconsStyle.regular)),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginRegisterPage()));
            },
            color: Colors.red,
            iconSize: 30,
          ),
        ],
      ),
      body: FutureBuilder(
          future: fetchVideoTape(),
          builder: (context, snapshot) {
            var data = snapshot.data;

            if (data != null) {
              return GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 20,
                    childAspectRatio: 2.5 / 3.5),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var videoTape = data[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Delete(videoTape: videoTape)));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "http://10.0.2.2:3000${videoTape.VideoTapeImage}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }
            return const Text('Loading..');
          }),
    );
  }
}
