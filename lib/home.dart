import 'dart:convert';

import 'package:ch10/model/posts_model.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/src/widgets/framework.dart';

import 'package:http/http.dart' as http;

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

// ignore: non_constant_identifier_names

class _homescreenState extends State<homescreen> {
  List<PostsModel> postlist = [];

  Future<List<PostsModel>> getApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = json.decode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> jsonItem in data) {
        postlist.add(PostsModel.fromJson(jsonItem));
      }
      return postlist;
    } else {
      return postlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getApi(),
              // Replace `yourFuture` with the actual Future you're waiting for
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('loading'); // Show a loading spinner
                } else {
                  // Build your widget tree using the data from the snapshot
                  return ListView.builder(
                      itemCount: postlist.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                txt(
                                    id: 'userId',
                                    value: postlist[index].userId.toString()),
                                txt(
                                    id: 'body',
                                    value: postlist[index].body.toString()),
                              ],
                            ),
                          ),
                        );
                      }); // Replace `YourWidget` with your actual widget
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class txt extends StatelessWidget {
  String id, value;
  txt({super.key, required this.id, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(id + '  ' + value);
  }
}
