import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  TextEditingController emailcontroler = TextEditingController();
  TextEditingController passwordcontroler = TextEditingController();

  void login(String email, String password) async {
    try {
      Response response =
          await post(Uri.parse('https://reqres.in/api/login'), body: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('Success');
      } else {
        print('Failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailcontroler,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: passwordcontroler,
              decoration: InputDecoration(hintText: 'password'),
            ),
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                login(emailcontroler.text.toString(),
                    passwordcontroler.text.toString());
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: Text('Sign Up'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
