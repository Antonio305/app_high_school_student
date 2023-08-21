import 'package:flutter/material.dart';
import 'package:prepa_estudiantes/src/model/horarios.dart';

import '../src/model/host.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

class HorarioServices extends ChangeNotifier {
  Horarios horario = Horarios(
      schoolYear: SchoolYear(
          id: '', initialDate: DateTime.now(), finalDate: DateTime.now()),
      semestre: GroupHorarios(id: '', name: ''),
      group: GroupHorarios(id: '', name: ''),
      hours: [],
      monday: [],
      tuesday: [],
      wednesday: [],
      thursday: [],
      friday: [],
      uid: '');

// base url
  String baseUrl = ConectionHost.baseUrl;

  // late Horarios horario;

  final Map<String, String> headers = {'Content-Type': 'application/json'};

  Future getHorario(
      String idGeneration, String idSemestre, String idGroup) async {
    // final url = Uri.http(
    //     baseUrl, '/api/horarios/$idGeneration/$idSemestre/$idGroup/forStudent');

    final url = ConectionHost.myUrl(
        '/api/horarios/$idGeneration/$idSemestre/$idGroup/forStudent', {});

    final resp = await http.get(url, headers: headers);

    final Map<String, dynamic> respBody = json.decode(resp.body);

    print(resp.body);
    horario = Horarios.fromJson(respBody);
    notifyListeners();
  }
}
