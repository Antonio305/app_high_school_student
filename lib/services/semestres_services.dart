import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:prepa_estudiantes/services/secure_storage.dart';
import 'package:prepa_estudiantes/src/model/semestre.dart';

import '../src/model/host.dart';

class SemestreServices extends ChangeNotifier {
// instance method securestorage

  final storage = SecureStorage.storage;
// intancie clas  in the semestre

  List<Semestres> semestres = [];

  bool status = false;

// methodo by get semestres

  // Future<List<Semestres>> getSemestres() async {
  Future getSemestres() async {
    final String? token = await storage.read(key: 'token');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      // 'x-token': token!
    };

    final url = ConectionHost.myUrl('/api/semestre', {});

    final resp = await http.get(url, headers: headers);
    print('Lista de los semestres ');
    print(resp.body);

    semestres = semestresFromJson(resp.body);
    notifyListeners();
    // return semestres;
  }

  Future<String?> addSemestreByStudent(List<String> listSemestre) async {
    final String? token = await storage.read(key: 'token');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-token': token!
    };

    final url = ConectionHost.myUrl(
        '/api/student/addSemestresToStudent/$listSemestre', {});
    final resp = await http.put(url, headers: headers);

    Map<String, dynamic> respBody = json.decode(resp.body);
    print('Dentro del semestre');
    print(resp.body);
    if (resp.statusCode == 201) {
      status = false;
      return respBody['msg'];
    }
    return null;
  }
}
