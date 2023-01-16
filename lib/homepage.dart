import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:todolist/insertpage.dart';
import 'package:todolist/updatepage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List list = [];
  Future getData() async {
    try {
      final response = await http
          .get(Uri.parse('http://127.0.0.1/simob/todolist/backend/list.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          list = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future deleteData(String id) async {
    try {
      final response = await http.post(
          Uri.parse('http://127.0.0.1/simob/todolist/backend/delete.php'),
          body: {'id_plan': id});
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => UpdatePage(
                                ListData: {
                                  'id_plan': list[index]['id_plan'],
                                  'teks': list[index]['teks'],
                                },
                              ))));
                },
                child: ListTile(
                  trailing: IconButton(
                      onPressed: () {
                        deleteData(list[index]['id_plan']).then((value) {
                          if (value) {
                            final snackBar = SnackBar(
                                content: const Text(
                                    'Your plan was successfully deleted'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            final snackBar = SnackBar(
                                content:
                                    const Text('Your plan failed to delete'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                              (route) => false);
                        });
                      },
                      icon: Icon(Icons.check_circle_outline)),
                  title: Text(list[index]['teks']),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => InsertPage())));
          }),
    );
  }
}
