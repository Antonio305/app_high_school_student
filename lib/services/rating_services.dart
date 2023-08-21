import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:prepa_estudiantes/services/secure_storage.dart';
import 'package:prepa_estudiantes/src/model/host.dart';

import 'package:http/http.dart' as http;
import 'package:prepa_estudiantes/src/model/rating.dart';
import 'package:prepa_estudiantes/src/widgets/show_alert.dart';

class RatingServices extends ChangeNotifier {
  // PARA VERIFICAR EL STATUS DELA CONSULE HTTP

  bool status = false;

  final storage = SecureStorage.storage;
// create conection host
  final String baseUrl = ConectionHost.baseUrl;

// headers
  final Map<String, String> header = {'Content-Type': 'applicatino/json'};

  Ratings rating = Ratings(
      id: '',
      student: '',
      semestre: '',
      subject: '',
      parcial1: 0,
      parcial2: 0,
      parcial3: 0,
      semesterGrade: 0,
      v: 0);

// usuario -  materia
  Future<String?> getRatingForMateria(
      String idStudent, String idSubject) async {
    // final url = Uri.http(baseUrl, '/api/rating/$idStudent/$idSubject/rating');

    final url =
        ConectionHost.myUrl('/api/rating/$idStudent/$idSubject/rating', {});
    status = true;
    notifyListeners();

    final resp =
        await http.get(url, headers: {'Content-Type': 'application/json'});

    Map<String, dynamic> respBody = json.decode(resp.body);
    // haremos una condicion si  tiene una calificacion elalumnos
    if (respBody.containsKey('msg')) {
      // print('NO HAY CALIFICACION DEL ALUMNO');
      return respBody['msg'];
    }

    rating = Ratings.fromJson(respBody);
    status = false;
    notifyListeners();
    print(respBody);
  }

  // para actualizar la calificacion
//  /api/rating

  Future updateRating(String idStudent) async {
    String? token = await storage.read(key: 'token');

    final Map<String, String> headers = {
      'Content-Type': 'applicatino/json',
      'x-token': token!
    };

    final url = ConectionHost.myUrl('/api/rating/$idStudent', {});

    final resp = await http.put(url, headers: headers);
    final respBody = json.decode(resp.body);

    print(respBody);
  }
}
