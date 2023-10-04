import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    testApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<void> testApi() async {
    var headers = {
      'accept': 'text/plain',
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('http://localhost:8000/lasotuvi/api?hoten=nam&gioitinh=nam&ngaysinh=23&thangsinh=11&namsinh=2022&amlich=on&giosinh=1&muigio=7'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }
}
