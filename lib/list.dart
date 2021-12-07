import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LISTA extends StatefulWidget {
  const LISTA({Key? key, required this.tittle}) : super(key: key);
  final String tittle;

  @override
  LISTAState createState() => new LISTAState();
}

class LISTAState extends State<LISTA> {
  final String url = 'https://pomodoroapp.azurewebsites.net/api/People';
  late List datas;

  Future<String> getdatas() async {
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    this.setState(() {
      datas = jsonDecode(response.body);
    });

    print(datas[1]['tarea']);

    return "Success!";
  }

  @override
  void initState() {
    this.getdatas();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Tareas Realizadas"), backgroundColor: Colors.red),
      body: new ListView.builder(
        itemCount: datas == null ? 0 : datas.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: new Text(datas[index]['tarea']),
          );
        },
      ),
    );
  }
}
