import 'dart:math';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:prepa_estudiantes/services/secure_storage.dart';
import 'dart:convert';

import 'package:prepa_estudiantes/src/model/host.dart';
import 'package:prepa_estudiantes/src/model/task_received.dart';

class TaskQualifieldServices extends ChangeNotifier {
  // instancia de la clasede donde se fuarda el token

  final storage = SecureStorage.storage;

  bool status = false;

  /// base url
  String baseUrl = ConectionHost.baseUrl;

  /// headers
  final Map<String, String> headers = {'Content-Type': 'application/json'};

  /// List model

  List<TaskReceived> taskReceived = [];

  List<TaskReceived> taskQualifieldBySubject = [];

  // function get

  // Obtenerr todas la tareas que se han enciado

  Future getAllTaskReceived(String idStudent) async {
    status = true;
    notifyListeners();

    // final url = Uri.http(baseUrl, '/api/taskReceived/$idStudent/student');
    final url = ConectionHost.myUrl('/api/taskReceived/$idStudent/student', {});
    final resp = await http.get(url, headers: headers);

    List<dynamic> respBody = json.decode(resp.body);

    final taskReceiveds =
        respBody.map((e) => TaskReceived.fromJson(e)).toList();
    taskReceived = [...taskReceiveds];
    notifyListeners();
    print(respBody);
    status = false;
    notifyListeners();
  }

  Future getAllTaskReceivedBySubjet(String idSubject) async {
    status = true;
    notifyListeners();

// inctacnai del storage
    String? token = await storage.read(key: 'token');

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      "x-token": token!
    };

    // final url = Uri.http(baseUrl, '/api/taskReceived/student/$idSubject');
    final url = ConectionHost.myUrl('/api/taskReceived/student/$idSubject', {});
    final resp = await http.get(url, headers: headers);

    List<dynamic> respBody = json.decode(resp.body);

    final taskReceiveds =
        respBody.map((e) => TaskReceived.fromJson(e)).toList();
    taskQualifieldBySubject = [...taskReceiveds];
    notifyListeners();

    print('tareas calificados por materia');
    print(respBody);
    status = false;
    notifyListeners();
  }
}
