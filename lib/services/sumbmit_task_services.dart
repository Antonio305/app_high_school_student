import 'package:flutter/material.dart';
import 'package:prepa_estudiantes/services/secure_storage.dart';
import 'package:prepa_estudiantes/src/model/host.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SendTaskServices extends ChangeNotifier {
  // para  visualizar el estado del envio de la tarea
  bool status = false;
  // url
  String baseUrl = ConectionHost.baseUrl;
  // headers -- encabezado

// intaicia de la clase de  doen de guarda el toen
  final storage = SecureStorage.storage;
  // send task
  Future sendTask(String idStudent, String idTask, String comments) async {
    String? token = await storage.read(key: 'token');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "x-token": token!
    };

    Map<String, String> data = {"task": idTask, "student": idStudent};

    // final url = Uri.http(baseUrl, '/api/taskReceived/student');
    final url = ConectionHost.myUrl('/api/taskReceived/student', {});

    status = true;
    notifyListeners();
    final resp = await http.post(url,
        headers: headers,
        body: json.encode({"task": idTask, "student": idStudent}));

    final respBody = json.decode(resp.body);
    print(respBody);

    status = false;
    notifyListeners();
  }

  // PAPRA VERIFICAR SI YA SE HA INGREDADO  LA TAREA
  // PARAMS: idTask, idStudent

  Future<Map<String, dynamic>> getByStudentTask(
      String idStudent, String idTask) async {
    String? token = await storage.read(key: 'token');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "x-token": token!
    };

    Map<String, String> data = {"task": idTask, "student": idStudent};

    // final url =
    //     Uri.http(baseUrl, '/api/taskReceived/student/$idTask/$idStudent');
    final url =
        ConectionHost.myUrl('/api/taskReceived/student/$idTask/$idStudent', {});

    status = true;
    notifyListeners();

    final resp = await http.get(url, headers: headers);

    Map<String, dynamic> respBody = json.decode(resp.body);
    print(respBody);

    status = false;
    notifyListeners();
    return respBody;
  }
}
