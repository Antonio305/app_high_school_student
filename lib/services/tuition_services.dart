import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prepa_estudiantes/services/secure_storage.dart';
import 'package:prepa_estudiantes/src/model/host.dart';
import 'package:prepa_estudiantes/src/model/tuition.dart';

import 'package:http/http.dart' as http;

class TuitionServices extends ChangeNotifier {
// para saber el estatus de esto
  bool status = false;

// conecion al servicor
  final String baseUrl = ConectionHost.baseUrl;

  // para el secure stoirage
  final storage = SecureStorage.storage;

  final Map<String, String> headers = {'Content-Type': 'application/json'};

  Tuitions tuition = Tuitions(
      tuition: '',
      createdAt: null,
      id: '',
      status: false,
      user: User(name: '', lastName: '', secondName: '', uid: ''));

// get all for tuition
  Future<Map<String, dynamic>> getTuitionName(String myTuition) async {
    status = true;
    notifyListeners();
    // final url = Uri.http(baseUrl, '/api/tuition/${myTuition}');
    final url = ConectionHost.myUrl('/api/tuition/${myTuition}', {});

    final resp = await http.get(url, headers: headers);
    // final Map<String, dynamic> respBody = json.decode(resp.body);

    Map<String, dynamic> respBody = json.decode(resp.body);
    print(respBody);

    if (respBody.containsKey('msg')) {
      print(respBody);
      status = false;
      notifyListeners();
      return respBody;
    }
    status = false;
    tuition = tuitionsFromJson(resp.body);
    notifyListeners();
    return respBody;

    // if (resp.statusCode == 200) {
    //   tuition = tuitionsFromJson(resp.body);
    //   status = false;
    //   notifyListeners();

    //   return tuition;
    // }
    // return null;

    //  tuition = Tuitions.fromJson(respBody);

    // if (respBody.containsKey('msg')) {
    //   // tuition = Tuitions(tuition: respBody['msg']);
    //   print(respBody);

    //   notifyListeners();
    //   return null;
    // }

    // status = true;
    // tuition = tuition.
    // notifyListeners();
    // return respBody;

    // print(respBody);

    // // tuition = Tuition.fromMap(respBody);
    // notifyListeners();
    // print(tuition.tuition);
  }
}
