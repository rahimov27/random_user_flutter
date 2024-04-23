// ignore_for_file: sized_box_for_whitespace

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:random_user/user_model.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String name = '';
  String username = '';
  String phone = '';
  String email = '';
  String image =
      'https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=';

  double lat = 0;
  double lan = 0;
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      appBar: AppBar(
        title: const Text("Random user"),
        elevation: 1,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: [
              ClipOval(
                child: Container(
                  width: 200, // Double the radius to maintain the size
                  height: 200, // Double the radius to maintain the size
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor:
                        Colors.transparent, // Make the background transparent
                    backgroundImage: NetworkImage(image),
                  ),
                ),
              ),
              // Container(
              //   width: 100,
              //   height: 100,
              //   child: Image.network(image),
              // ),
              const SizedBox(height: 50),
              TextFieldWidget(
                text: name,
              ),
              TextFieldWidget(
                text: username,
              ),
              TextFieldWidget(
                text: phone,
              ),
              TextFieldWidget(
                text: email,
              ),
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.black26, // Adjust the radius as needed
                  // Add a border if necessary
                ),
                child: TextButton(
                  onPressed: () {
                    getData();
                    setState(() {});
                    // Add your onPressed function here
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getData() async {
    final Dio dio = Dio();
    final response = await dio.get('https://randomuser.me/api/');
    final result = UserModel.fromJson(response.data);

    name =
        '${result.results?.first.name?.first} ${result.results?.first.name?.last}';
    username = result.results?.first.login?.username ?? '';
    phone = result.results?.first.phone ?? '';
    email = result.results?.first.email ?? '';
    image = result.results?.first.picture?.large ?? '';
    lat = double.tryParse(
            result.results?.first.location?.coordinates?.latitude ?? '') ??
        0;
    lan = double.tryParse(
            result.results?.first.location?.coordinates?.longitude ?? '') ??
        0;
    ;
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration:
          InputDecoration(border: const OutlineInputBorder(), hintText: text),
    );
  }
}
