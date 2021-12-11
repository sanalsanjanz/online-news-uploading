// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Update extends StatefulWidget {
  const Update({Key? key}) : super(key: key);

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final _formKey = GlobalKey<FormFieldState>();
  final headindController = TextEditingController();
  final newsController = TextEditingController();
  final imageController = TextEditingController(
      text:
          'https://firebasestorage.googleapis.com/v0/b/coin-e80fb.appspot.com/o/Noimage.jpeg?alt=media&token=97182f7c-1ff2-4bd1-ae76-d5de13fa4019');

  @override
  Widget build(BuildContext context) {
    final space = SizedBox(
      height: 20,
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Upload News',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              space,
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Enter valid information");
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: 'Heading'),
                controller: headindController,
              ),
              space,
              TextFormField(
                controller: imageController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Enter valid information");
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: 'Image Link',
                ),
              ),
              space,
              TextFormField(
                controller: newsController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Enter valid information");
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: 'Enter News Content here ...',
                    labelText: 'News'),
                maxLines: 20,
              ),
              space,
              ElevatedButton(
                  onPressed: () {
                    Map<String, dynamic> data = {
                      "heading": headindController.text,
                      "news": newsController.text,
                      'image': imageController.text,
                    };
                    FirebaseFirestore.instance.collection('news').add(data);
                    headindController.clear();
                    newsController.clear();
                    imageController.clear();
                  },
                  child: const Text("Upload"))
            ],
          ),
        ),
      ),
    );
  }
}
