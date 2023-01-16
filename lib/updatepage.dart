import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:todolist/homepage.dart';

class UpdatePage extends StatefulWidget {
  final Map ListData;
  const UpdatePage({super.key, required this.ListData});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController teks = TextEditingController();
  TextEditingController id_plan = TextEditingController();
  Future _update() async {
    final response = await http.post(
        Uri.parse('http://127.0.0.1/simob/todolist/backend/update.php'),
        body: {
          'id_plan': id_plan.text,
          'teks': teks.text,
        });
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    id_plan.text = widget.ListData['id_plan'];
    teks.text = widget.ListData['teks'];
    return Scaffold(
      appBar: AppBar(title: Text('Update To do')),
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
                      _update().then((value) {
                        if (value) {
                          final snackBar = SnackBar(
                              content: const Text(
                                  'Your plan was successfully updated'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          final snackBar = SnackBar(
                              content:
                                  const Text('Your plan failed to update'));
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
