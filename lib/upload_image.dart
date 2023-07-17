import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class uploadimage extends StatefulWidget {
  const uploadimage({super.key});

  @override
  State<uploadimage> createState() => _uploadimageState();
}

class _uploadimageState extends State<uploadimage> {
  final _picker = ImagePicker();
  File? image;
  bool showSppiner = false;

  Future getimage() async {
    final pickedfile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedfile != null) {
      image = File(pickedfile.path);

      setState(() {});
    } else {
      print('no Selected');
    }
  }

  Future uploadimage() async {
    setState(() {
      showSppiner = true;
    });

    var stream = new http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();

    var url = Uri.parse('https://fakestoreapi.com/products');

    var request = new http.MultipartRequest('POST', url);
    request.fields['title'] = 'fazal';
    var mulport = new http.MultipartFile('image', stream, length);
    request.files.add(mulport);

    var response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        showSppiner = false;
      });

      print('Image Uploaded');
    } else {
      print('Failed');

      setState(() {
        showSppiner = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSppiner,
      child: Scaffold(
        appBar: AppBar(title: Text('Uplaod Image')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                getimage();
              },
              child: Container(
                child: image == null
                    ? Center(
                        child: Text('Pic Image'),
                      )
                    : Container(
                        child: Center(
                          child: Image.file(
                            File(image!.path).absolute,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                uploadimage();
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: Text('Uploaded'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
