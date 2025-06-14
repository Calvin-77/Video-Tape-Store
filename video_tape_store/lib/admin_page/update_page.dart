import 'package:flutter/material.dart';
import 'package:video_tape_store/admin_page/home_page.dart';
import 'package:video_tape_store/models/video_tape.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Update extends StatefulWidget {
  final VideoTape videoTape;

  const Update({super.key, required this.videoTape});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  var _titleController = TextEditingController();
  var _priceController = TextEditingController();
  var _descriptionController = TextEditingController();
  var _genreIDController = TextEditingController();
  var _levelController = TextEditingController();

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.videoTape.Title);
    _priceController =
        TextEditingController(text: widget.videoTape.Price.toString());
    _descriptionController =
        TextEditingController(text: widget.videoTape.Description);
    _genreIDController =
        TextEditingController(text: widget.videoTape.Genre.toString());
    _levelController =
        TextEditingController(text: widget.videoTape.Level.toString());
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Image picking error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gagal mengambil gambar")));
    }
  }

  void UpdatePressed(BuildContext context) async {
    if (_titleController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _genreIDController.text.isEmpty ||
        _levelController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Semua kolom wajib diisi!")));
      return;
    }

    try {
      String url = "http://10.0.2.2:3000/videos/update";

      var request = http.MultipartRequest('PUT', Uri.parse(url));

      request.fields['VideoTapeID'] = widget.videoTape.VideoTapeID.toString();
      request.fields['Title'] = _titleController.text;
      request.fields['Price'] = _priceController.text;
      request.fields['Description'] = _descriptionController.text;
      request.fields['GenreID'] = _genreIDController.text;
      request.fields['Level'] = _levelController.text;

      if (_imageFile != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', _imageFile!.path));
      } else {
        request.fields['VideoTapeImage'] = widget.videoTape.VideoTapeImage;
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text("Gagal memperbaharui data: ${response.reasonPhrase}")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 40,
        iconTheme: const IconThemeData(color: Color(0xFF0075D4)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageFile == null)
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: 500,
                height: 350,
                child: Image.network(
                  "http://10.0.2.2:3000${widget.videoTape.VideoTapeImage}",
                  fit: BoxFit.cover,
                ),
              ),
            if (_imageFile != null)
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: 500,
                height: 350,
                child: Image.file(_imageFile!, fit: BoxFit.cover),
              ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: IconButton(
                  onPressed: _pickImage,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white),
                  icon: const Icon(Icons.image)),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                controller: _titleController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(width: 2, color: Colors.red),
                    ),
                    labelText: "Title",
                    hintText: "ex: Beauty and The Beast",
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: const TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                controller: _priceController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(width: 2, color: Colors.red),
                    ),
                    labelText: "Price",
                    hintText: "ex: 25000",
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: const TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                maxLines: null,
                minLines: 1,
                controller: _descriptionController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(width: 2, color: Colors.red),
                    ),
                    labelText: "Description",
                    hintText: "ex: Beauty and The Beast is a...",
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: const TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                controller: _genreIDController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(width: 2, color: Colors.red),
                    ),
                    labelText: "Genre",
                    hintText: "ex: Romance",
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: const TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextField(
                controller: _levelController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(width: 2, color: Colors.red),
                    ),
                    labelText: "Level",
                    hintText: "ex: 18+",
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: const TextStyle(color: Colors.white)),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: ElevatedButton(
                    onPressed: () => UpdatePressed(context),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white),
                    child: const Text("Update")))
          ],
        ),
      ),
    );
  }
}
