import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:ui';
import 'Imagens_API.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BemVindo extends StatefulWidget {
  const BemVindo({Key? key}) : super(key: key);

  @override
  State<BemVindo> createState() => _BemVindoState();
}

class _BemVindoState extends State<BemVindo> {
  var title = 'Lista de Imagens';

  Future<List<Imagens>> getAllImagens() async {
    const url = 'http://127.0.0.1:5000/PegaImagens';

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    List<Imagens> images = [];
    for (var jsonImagens in jsonData) {
      Imagens imagens = Imagens(
          descricao: jsonImagens['descricao'], image: jsonImagens['image']);

      images.add(imagens);
    }
    return images;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: title,
        home: Scaffold(
            appBar: AppBar(
              title: Text(title),
              backgroundColor: Colors.greenAccent,
            ),
            body: FutureBuilder<List<Imagens>>(
              future: getAllImagens(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<Imagens> images = snapshot.data!;
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Imagens imagens = images[index];

                        return Container(
                          child: Column(
                            children: [
                              Image.network(
                                imagens.image,
                                width: 100,
                                height: 80,
                              ),
                              Text(
                                imagens.descricao,
                                style: TextStyle(
                                    fontSize: 30, color: Colors.black),
                              )
                            ],
                          ),
                        );
                      });
                }
              },
            )));
  }
}
