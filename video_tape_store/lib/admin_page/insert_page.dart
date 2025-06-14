import 'package:flutter/material.dart';
import 'package:video_tape_store/admin_page/home_page.dart';
import 'package:video_tape_store/style/style.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class Insert extends StatefulWidget {
  const Insert({super.key});

  @override
  State<Insert> createState() => __InsertState();
}

class __InsertState extends State<Insert> {
  var Title = TextEditingController();
  var Price = TextEditingController();
  var Description = TextEditingController();
  var Genre = TextEditingController();
  var Level = TextEditingController();

  File? _portraitImageFile;
  File? _landscapeImageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImagePortrait() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _portraitImageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Image picking error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gagal mengambil gambar")));
    }
  }

  Future<void> _pickImageLandscape() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _landscapeImageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Image picking error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gagal mengambil gambar")));
    }
  }

  void InsertionPressed(BuildContext context) async {
    if (Title.text.isEmpty ||
        Price.text.isEmpty ||
        Description.text.isEmpty ||
        Genre.text.isEmpty ||
        Level.text.isEmpty ||
        _portraitImageFile == null ||
        _landscapeImageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Semua kolom wajib diisi!")));
      return;
    }
    try {
      String url = "http://10.0.2.2:3000/videos/insert";

      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields['Title'] = Title.text;
      request.fields['Price'] = Price.text;
      request.fields['Description'] = Description.text;
      request.fields['Genre'] = Genre.text;
      request.fields['Level'] = Level.text;

      if (_portraitImageFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'portraitImage', _portraitImageFile!.path));
      }

      if (_landscapeImageFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'landscapeImage', _landscapeImageFile!.path));
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Gagal memasukkan data: ${response.reasonPhrase}")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Insert New VideoTape'),
        titleTextStyle: AppTextStyle.title(context),
        backgroundColor: Theme.of(context).colorScheme.surface,
        toolbarHeight: 40,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                controller: Title,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Title",
                    hintText: "Enter Title Name",
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: const TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                controller: Price,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Price",
                    hintText: "Enter Price",
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: const TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                maxLines: null,
                minLines: 1,
                controller: Description,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Description",
                    hintText: "Enter Description or Sinopsis",
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: const TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                controller: Genre,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Genre",
                    hintText: "Enter Genre",
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: const TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                controller: Level,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Level",
                    hintText: "Enter Level",
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: const TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: ElevatedButton(
                  onPressed: _pickImagePortrait,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white),
                  child: const Text("Pick Image (Portrait)")),
            ),
            if (_portraitImageFile != null)
              Expanded(
                child: Image.file(_portraitImageFile!, fit: BoxFit.cover),
              ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: ElevatedButton(
                  onPressed: _pickImageLandscape,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white),
                  child: const Text("Pick Image (Landscape)")),
            ),
            if (_landscapeImageFile != null)
              Expanded(
                child: Image.file(_landscapeImageFile!, fit: BoxFit.cover),
              ),
            Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: ElevatedButton(
                    onPressed: () => InsertionPressed(context),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white),
                    child: const Text("Insert")))
          ],
        ),
      ),
    );
  }
}
