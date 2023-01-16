import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:todolist/homepage.dart';

class InsertPage extends StatefulWidget {
  const InsertPage({super.key});

  @override
  State<InsertPage> createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController teks = TextEditingController();
  Future _simpan() async {
    final response = await http.post(
        Uri.parse('http://127.0.0.1/simob/todolist/backend/create.php'),
        body: {
          'teks': teks.text,
        });
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Insert To do')),
      body: Form(
          key: formKey,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(children: [
              TextFormField(
                  controller: teks,
                  decoration: InputDecoration(
                      hintText: 'Your Plan',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please fill this field!";
                    }
                  }),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      _simpan().then((value) {
                        if (value) {
                          final snackBar = SnackBar(
                              content: const Text(
                                  'Your plan was successfully added'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          final snackBar = SnackBar(
                              content: const Text('Your plan failed to add'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      });
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                          (route) => false);
                    }
                  },
                  child: Text('Save'))
            ]),
          )),
    );
  }
}
