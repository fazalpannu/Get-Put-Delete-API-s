import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/user_model.dart';

// ignore: camel_case_types
class usermodel extends StatefulWidget {
  const usermodel({super.key});

  @override
  State<usermodel> createState() => _usermodelState();
}

class _usermodelState extends State<usermodel> {
  List<UserModel> user = [];

  Future<List<UserModel>> getApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = json.decode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> jsonItem in data) {
        user.add(UserModel.fromJson(jsonItem));
      }
      return user;
    } else {
      return user;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: FutureBuilder(
          future: getApi(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                itemCount: user.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                        children: [
                          Reuseablerow(
                              name: 'Name    :',
                              value: user[index].name.toString()),
                          Reuseablerow(
                              name: 'Email  :',
                              value: user[index].email.toString()),
                          Reuseablerow(
                              name: 'Website :',
                              value: user[index].website.toString()),
                          Reuseablerow(
                              name: 'city in Address :',
                              value: user[index].address!.city.toString()),
                          Reuseablerow(
                              name: 'lat in geo  in Address :',
                              value: user[index].address!.geo!.lat.toString()),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ))
      ],
    );
  }
}

class Reuseablerow extends StatelessWidget {
  String name, value;

  Reuseablerow({super.key, required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name),
        SizedBox(
          height: 35,
        ),
        Text(value)
      ],
    );
  }
}
