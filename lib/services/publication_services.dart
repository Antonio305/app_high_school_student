import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:prepa_estudiantes/services/secure_storage.dart';

import '../src/model/host.dart';
import '../src/model/publication.dart';

class PublicationServices extends ChangeNotifier {
  //  url
  String baseUrl = ConectionHost.baseUrl;

  Map<String, String> headers = {'Content-Type': 'application/json'};

  List<Publication> publication = [];

  // instance storage
  final storage = SecureStorage.storage;

// metodos
  // all publication

  Future allPublication() async {
    // final url = Uri.http(baseUrl, '/api/publication');
    final url = ConectionHost.myUrl('/api/publication', {});

    final resp = await http.get(url, headers: headers);

    final List<dynamic> respBody = json.decode(resp.body);

    final _publication = respBody.map((e) => Publication.fromMap(e)).toList();
    publication = [..._publication];
    notifyListeners();
    print(respBody);
  }

// la function se ejecura dependicneo si esta o no creado la publicacion
//   Future createPublicationOrUpdatePublication(String idPublication) async {}

//   // create publicatio
//   Future<String> createPublication(String title, String description) async {
//     final url = Uri.http(baseUrl, '/api/publication');
//     String? token = await storage.read(key: 'token');

//     final resp = await http.post(url,
//         headers: {'Content-Type': 'application/json', 'x-token': token!},
//         body: json.encode({"title": title, "description": description}));

//     final respBody = json.decode(resp.body);

//     print(respBody);
//     return respBody['_id'];
//   }

//   // update publication
//   Future updateaPublication(Publication publication) async {
//     final url = Uri.http(baseUrl, '/api/publication/${publication.id}');
//     String? token = await storage.read(key: 'token');

//     final resp = await http.put(url,
//         headers: {'Content-Type': 'application/json', 'x-token': token!},
//         body: publication.toJson());

//     final respBody = json.decode(resp.body);
//     print(respBody);
//   }
}
