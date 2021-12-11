// ignore_for_file: prefer_const_constructors

import 'package:alpha/adiminLogin/Admin.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Center(child: Text("Something coming soon"))),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Admins(),
                  ),
                );
              },
              child: Text("admins"),
            )
          ],
        ),
      ),
    );
  }
}
