import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prepa_estudiantes/services/secure_storage.dart';
import 'package:prepa_estudiantes/src/model/host.dart';

import '../src/model/subjects.dart';

class SubjectServices extends ChangeNotifier {
// PARA VER EL ESTADO DE LA PETICION
  bool status = false;  
  // PARA VER EL  ESTADO DE LA CARGA DE LAS MATERIAS
bool statusAllSubject = false;
  
  // int index
  int indexSelected = 0;

//   intancia de la clase de donde se guarda el toekn

  final storage = SecureStorage.storage;

  List<Subjects> subjects = [];

  // final String baseUrl = "localhost:8080";
  final String baseUrl = ConectionHost.baseUrl;

  Future allSubjectForSemestre(String idSemestre) async {
    String? token = await storage.read(key: 'token');

    // crear map by headers
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-token': token!
    };

    statusAllSubject = true;
    notifyListeners();

    // final url = Uri.http(baseUrl, 'api/matery/student/$idSemestre');
    final url = ConectionHost.myUrl('api/matery/student/$idSemestre', {});

    final resp = await http.get(url, headers: headers);

    final List respBody = json.decode(resp.body);
    // print('LIST DE SUBJECTS');
    // print(resp.body);

    // ageregamos los datos en la lista
    statusAllSubject = false;
    subjects = respBody.map((value) => Subjects.fromJson(value)).toList();
    notifyListeners();
  }

  // metodo para agrefar la lista de materias a los estudiantes dependiendo del semestre
  Future<String?> addSubjectByStudent(List<String> listSubjects) async {
    String? token = await storage.read(key: 'token');

    // crear map by headers
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-token': token!
    };

    // final url = ConectionHost.mFyUrl('api/matery/student/:id/', {});
    final url = ConectionHost.myUrl(
        '/api/student/addSubjectsToStudent/$listSubjects', {});

    status = true;
    notifyListeners();

    final resp = await http.put(url, headers: headers);

    // final respBody = json.decode(resp.body);
    Map<String, dynamic> respBody = json.decode(resp.body);

    print(respBody);

    if (resp.statusCode == 201) {
      status = false;
      notifyListeners();
      return respBody['msg'];
    } else {
      status = false;
      notifyListeners();
      return null;
    }

    // status = false;
    // notifyListeners();
  }
}
