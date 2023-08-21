import 'package:flutter/material.dart';
import 'package:prepa_estudiantes/services/secure_storage.dart';
import 'package:prepa_estudiantes/src/model/host.dart';
// para  ontener las tareas
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../src/model/task.dart';

// createl iist por type Tasks, inicialixe with list empty

class TaskServices extends ChangeNotifier {
  // PARA VER EL ESTADO DE LA PETICIOH
  bool status = false;

// isntiacia de SecxureStorage
  final storage = SecureStorage.storage;

  // base url
  // final String baserUrl = 'localhost:8080';
  final String baseUrl = ConectionHost.baseUrl;
  // final headers = {'content-Type': 'application/json'};

// All tasks
  List<Tasks> tasks = [];

  // all tasks by subject
  List<Tasks> tasksBySubject = [];

  /// creater function getb task by where generatiom group , smestrer, teacher jeeeeya

  Future getTaskStudent(generation, String semestre, String group,
      List<String> idStudents) async {
    // GENRATE URL

    status = true;
    notifyListeners();

    // final url = Uri.http(baseUrl, '/api/tasks/student/$group/$idStudents');
    final url =
        ConectionHost.myUrl('/api/tasks/student/$group/$idStudents', {});

    // final  url = Uri.parse('https://backendprepa-production.up.railway.app/api/tasks');

    String? token = await storage.read(key: 'token');

// en le hader soo se va a pasar el token
    final resp = await http.get(url, headers: {
      'content-Type': 'application/json',
      "x-token": token!,
    });

    final List<dynamic> respBody = json.decode(resp.body);
    print(respBody);

    tasks = respBody.map((e) => Tasks.fromJson(e)).toList();
    status = false;
    notifyListeners();
  }

  Future getTaskStentBySubject(String group, String idSubject) async {
    // GENRATE URL

    status = true;
    notifyListeners();

    // final url =
    // Uri.http(baseUrl, '/api/tasks/student/bySubject/$group/$idSubject');
    final url = ConectionHost.myUrl(
        '/api/tasks/student/bySubject/$group/$idSubject', {});

    // final  url = Uri.parse('https://backendprepa-production.up.railway.app/api/tasks');

    String? token = await storage.read(key: 'token');

// en le hader soo se va a pasar el token
    final resp = await http.get(url, headers: {
      'content-Type': 'application/json',
      "x-token": token!,
    });

    final List<dynamic> respBody = json.decode(resp.body);

    tasksBySubject = respBody.map((e) => Tasks.fromJson(e)).toList();
    print('LISTA DE LAS TAREAS');
    print(respBody);

    status = false;
    notifyListeners();
    // print(tasks);
  }
}
