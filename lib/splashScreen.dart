// ignore_for_file: prefer_const_constructors, file_names, sized_box_for_whitespace
import 'dart:async';
import 'package:alpha/screens/news.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => NewsPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Expanded(
            child: SizedBox(
              // color: Colors.green,
              width: double.maxFinite,
              height: 200,
              child: Image(
                image: AssetImage('assets/social.png'),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CircularProgressIndicator(),

          SizedBox(
            height: 20,
          ),
          // LottieBuilder.asset('assets/share.json', repeat: true),
        ],
      ),
    );
  }
}
