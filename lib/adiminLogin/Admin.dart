// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:alpha/screens/update.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Admins extends StatefulWidget {
  const Admins({Key? key}) : super(key: key);

  @override
  _AdminsState createState() => _AdminsState();
}

class _AdminsState extends State<Admins> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController adEmail = TextEditingController();
  final TextEditingController adPassword = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adimin login"),
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Enter valid email");
                    }
                  },
                  controller: adEmail,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: 'Registered Email',
                      labelText: 'Email'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Enter valid password");
                    }
                  },
                  controller: adPassword,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'security code',
                      labelText: 'password'),
                ),
              ),
              ElevatedButton(
                child: Text("Enter"),
                onPressed: () {
                  login(adEmail.text, adPassword.text);
                  savedata();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  savedata() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setString('savedvalue', adEmail.text);
  }

  void login(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Update(),
                  ),
                ),
              });
    }
  }
}
