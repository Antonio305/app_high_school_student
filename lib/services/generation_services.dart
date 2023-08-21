import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:prepa_estudiantes/src/model/generations.dart';
import 'package:prepa_estudiantes/src/model/host.dart';
import 'package:prepa_estudiantes/src/model/semestres.dart';


class GenerationServices extends ChangeNotifier {
  List<Generation> generations = [];

  // clase para la lista del seemestre
  List<Semestre> semestres = [];
  // late Generation generation;

  Map<String, dynamic> generation = {};

  final String baseUrl = ConectionHost.baseUrl;
  final headers = {'content-Type': 'applicacion/json'};

  // //  hacemos la llmada dentro del constructot
  // GenerationServices(){
  //   allGeneration();
  // }

  Future allGeneration() async {
    // final url = Uri.http(baseUrl, 'api/generation');
    final url = ConectionHost.myUrl('/api/generation', {});

    final resp = await http.get(url, headers: headers);
    final List<dynamic> respBody = json.decode(resp.body);

    final generation = respBody.map((e) => Generation.fromMap(e)).toList();

    generations = [...generation];
    notifyListeners();
    // if (resp.statusCode == 200) {
    //   // print('datos obtenidos con exito las generaciones');
    //  print(respBody[1]);
    // } else {
    //   print('Ya valio chetos');
    // }
  }

// funcion para mostrar los dato semestres y grupos por generaciones
  Future getGroupSemestreForGeneration(String id) async {
    // final url = Uri.http(baseUrl, 'api/generation/$id');
    final url = ConectionHost.myUrl('api/generation/$id', {});

    final resp = await http.get(url, headers: headers);

    final Map<String, dynamic> respBody = json.decode(resp.body);

    // generation = json.decode(resp.body);

    // generation = Generation.fromMap(respBody);
    // print(generation);

    print('Datoss del a genraicon');
    // print(respBody['semestre']);

    List<dynamic> semestre = respBody['semestre'];

    semestres = semestre.map((e) => Semestre.fromMap(e)).toList();

    print(semestres);
    // print('Datos del grupo');
    // print(semestre[0]);

    // final Map<String, dynamic> groups = semestre[0];
    // final List<dynamic> dataGroups = groups['group'];

    // print('datos del grup' + semestre);
    // generation = json.decode(resp.body);

    // generation = Generation(
    //     initialDate: respBody['initialDate'],
    //     finalDate: respBody['finalDate'],
    //     semestre: respBody['semestre'],
    //     uid: respBody['uid']);
    // // generation = Generation.fromMap(respBody);

    // print('dato de la  generacion');
    // print(generation);

    // return generation;
    // final groupSemestreForGeneration =
  }
}
