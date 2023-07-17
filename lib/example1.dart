import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class exampleone extends StatefulWidget {
  const exampleone({super.key});

  @override
  State<exampleone> createState() => _exampleoneState();
}

class _exampleoneState extends State<exampleone> {
  List<Photos> photos = [];

  Future<List<Photos>> getApi() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = json.decode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> jsonItem in data) {
        photos.add(Photos(title: jsonItem['title'], url: jsonItem['url']));
      }
      return photos;
    } else {
      return photos;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getApi(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text('Loasding');
                  } else {
                    return ListView.builder(
                      itemCount: photos.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(photos[index].title.toString()),
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(photos[index].url.toString()),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class txt extends StatelessWidget {
  const txt({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// Constructor
class Photos {
  String? title;
  String? url;

  // Constructor
  Photos({required String title, required String url}) {
    this.title = title;
    this.url = url;
  }
}
