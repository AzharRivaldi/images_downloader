import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

class PageViews extends StatefulWidget {
  final String strKategori;
  final String strThumbUser;
  final String strType;
  final String strTags;
  final String strUsername;

  const PageViews({super.key, required this.strKategori, required this.strThumbUser,
      required this.strType, required this.strTags, required this.strUsername});

  @override
  State<PageViews> createState() => PageViewsState();
}

class PageViewsState extends State<PageViews> {
  late String strKategori, strThumbUser, strType, strTags, strUsername, strMessage;
  Uint8List? bytes;

  @override
  void initState() {
    super.initState();
    strKategori = widget.strKategori;
    strThumbUser = widget.strThumbUser;
    strType = widget.strType;
    strTags = widget.strTags;
    strUsername = widget.strUsername;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(strKategori),
                        fit: BoxFit.cover
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      end: const Alignment(0.0, 0.4),
                      begin: const Alignment(0.0, 1),
                      colors: [Colors.white, Colors.white.withOpacity(0.0)],
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(strThumbUser),
                backgroundColor: Colors.transparent,
              ),
              title: Text(strUsername),
              subtitle: Text(strType),
            ),
            const SizedBox(height: 10),
            Center(
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Color(0xff201f1f),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Text(
                  strTags,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipOval(
                  child: Material(
                    color: const Color(0xff201f1f),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const SizedBox(
                          width: 46,
                          height: 46,
                          child: Icon(Icons.arrow_back, color: Colors.white)
                      ),
                    ),
                  ),
                ),
                ClipOval(
                  child: Material(
                    color: const Color(0xff201f1f),
                    child: InkWell(
                      onTap: () {},
                      child: const SizedBox(
                          width: 46,
                          height: 46,
                          child: Icon(Icons.favorite_border, color: Colors.white)
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: const Color(0xfffde568)
                  ),
                  child: const Text('Download Image',
                      style: TextStyle(color: Color(0xff201f1f))
                  ),
                  onPressed: () {
                    saveImage(strKategori);
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  //method save image
  Future saveImage(String bytes) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      final http.Response response = await http.get(Uri.parse(bytes));
      final dir = await getTemporaryDirectory();

      var random = Random();
      var filename = '${dir.path}/SaveImage_${random.nextInt(100)}.jpg';

      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);

      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);

      if (finalPath != null) {
        strMessage = 'Image saved to disk';
      }
    } catch (e) {
      scaffoldMessenger.showSnackBar(SnackBar(
        content: Text(
          strMessage = e.toString(),
          style: const TextStyle(color: Color(0xff201f1f), fontSize: 14),
        ),
        backgroundColor: const Color(0xfffde568),
      ));
    }
    scaffoldMessenger.showSnackBar(SnackBar(
      content: Text(
        strMessage,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xff201f1f),
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0xfffde568),
    ));
  }
}
