// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:alpha/adiminLogin/Admin.dart';
import 'package:alpha/pageAnimation.dart';
import 'package:alpha/screens/about.dart';
import 'package:alpha/screens/update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final abs = FirebaseFirestore.instance.collection("news").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 60,
        /* flexibleSpace: Container(
          decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          height: 150,
        ), */
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.black12),
        backgroundColor: Colors.white12,
        centerTitle: true,
        title: Text(
          'MalluKerala',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.admin_panel_settings,
            color: Colors.black,
          ),
          onPressed: () {
            getSavedValue();
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  PageAnimations(
                    widget: About(),
                  ),
                );
              },
              icon: Icon(
                Icons.info,
                color: Colors.black,
              ))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("news").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return PageView(scrollDirection: Axis.horizontal, children: [
              ...snapshot.data!.docs.map((document) {
                return ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    //fetching image from firestore
                    Container(
                      margin:
                          EdgeInsets.only(left: 8, bottom: 8, right: 8, top: 5),
                      //color: Colors.transparent,
                      height: 300,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(document['image']),
                        ),
                      ),
                    ),

                    ListView(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            document['heading'],
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15.0, right: 15),
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          padding: const EdgeInsets.only(
                              bottom: 20.0, left: 8, right: 8),
                          child: Text(
                            document['news'],
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontSize: 20,
                                height: 1.8,
                                // wordSpacing: 0.8,
                                letterSpacing: 0.5),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ]);
          }
        },
      ),
    );
  }

  Future<void> getSavedValue() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final savedValue = sharedPrefs.getString('savedvalue');
    if (savedValue != null) {
      Navigator.of(context).push(PageAnimations(widget: Update()));
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Admins(),
        ),
      );
    }
  }
}
