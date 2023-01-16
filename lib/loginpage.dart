import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist/homepage.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var id_user = '';
  final formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  Future _login() async {
    final response = await http.post(
        Uri.parse('http://127.0.0.1/simob/todolist/backend/login.php'),
        body: {
          'username': username.text,
          'password': password.text,
        });
    var datauser = jsonDecode(response.body);
    id_user = datauser[0]['id_user'];
    if (datauser.length == 0) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white30,
      body: Form(
        key: formKey,
        child: SafeArea(
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              // Hello again
              Image.asset('reading.png'),

              Text(
                'WHATS YOUR PLAN TODAY?',
                style: GoogleFonts.nerkoOne(fontSize: 24),
              ),

              Text(
                'STAY HEALTHY AND BE HAPPY',
                style: GoogleFonts.nerkoOne(fontSize: 24),
              ),

              SizedBox(height: 35),

              // input email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextFormField(
                    controller: username,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14.0),
                      hintText: 'Username',
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color(0xff7B8794),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please fill this field!";
                      }
                    },
                  ),
                ),
              ),

              SizedBox(height: 10),

              // input password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14.0),
                      hintText: 'Password',
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color(0xff7B8794),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please fill this field!";
                      }
                    },
                  ),
                ),
              ),

              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      _login().then((value) {
                        if (value) {
                          final snackBar = SnackBar(
                              content: const Text('Sign In was Successfully'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          var route = MaterialPageRoute(
                              builder: (BuildContext context) => HomePage(
                                    id_user: id_user,
                                    key: (null),
                                  ));
                          Navigator.pushReplacement(context, route);
                        } else {
                          final snackBar =
                              SnackBar(content: const Text('Sign In failed'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red[400],
                      shape: StadiumBorder(),
                      minimumSize: Size(300, 70)),
                  child: Text('Sign In',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18))),
              SizedBox(height: 25),
            ]),
          ),
        ),
      ),
    );
  }
}
