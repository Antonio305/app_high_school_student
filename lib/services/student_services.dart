import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prepa_estudiantes/services/secure_storage.dart';
import 'package:prepa_estudiantes/src/model/for_create_student.dart';
// import 'package:prepa_estudiantes/src/model/for_create_student.dart';

import 'dart:convert';

import '../src/model/host.dart';
// import '../src/model/student.dart';
// import '../src/model/student.dart';
import '../src/model/student.dart';
import 'login_services.dart';

class StudentServices extends ChangeNotifier {
  // para verificar el estado de los estados
  bool status = false;

  // final String baseUrl = "localhost:8080";
  // final String baseUrl = '192.168.1.66:8080';
  final String baseUrl = ConectionHost.baseUrl;

  final headers = {'content-type': 'application/json'};

  final login = LoginServices();

  // get students
  final storage = SecureStorage.storage;

  // List<Student> students = [];

  Student student = Student(
    studentTutor: StudentTutor(
        nameTutor: "",
        lastNameTutor: "",
        secondNameTutor: "",
        kinship: "",
        numberPhoneTutor: 0),
    name: "",
    lastName: "",
    secondName: "",
    gender: "",
    dateOfBirth: DateTime.now(),
    bloodGrade: "",
    curp: "",
    age: 0,
    town: "",
    numberPhone: 0,
    tuition: "",
    password: "",
    status: false,
    rol: "",
    group: Group(id: "", name: "", adviser: "", tutor: "", semestre: "", v: 0),
    semestre: [
      Semestre(
          id: "",
          name: "",
          periodic: "",
          // initialDate: DateTime.now(),
          // endDate: DateTime.now(),
          v: 0)
    ],
    subjects: [Subject(id: "0", name: "", teachers: "", semestre: "", v: 0)],
    generation: Generation(
        id: "", initialDate: DateTime.now(), finalDate: DateTime.now(), v: 0),
  );

  // Future getStude

/*
 Function to get student data by ID
 */

  Future getStudentForID(String? token) async {
    // final url = Uri.http(baseUrl, 'api/student/students');
    // final  url = Uri.parse('https://backendprepa-production.up.railway.app/api/student/students');

    final url = ConectionHost.myUrl('api/student/students', {});
    print(url);

    final resp = await http.get(url, headers: {
      'content-type': 'application/json',
      "x-token": "$token",
    });

    final Map<String, dynamic> respBody = json.decode(resp.body);

    student = Student.fromMap(respBody);
    notifyListeners();
    // print(respBody);

    // return student;
  }

  Future registerStudent(StudentByResgister student) async {
    String? token = await storage.read(key: 'token');

    Map<String, String> headers = {
      'content-type': 'application/json',
      // 'x-token': token!
    };

    status = true;
    ChangeNotifier();

    // final url = Uri.http(baseUrl, '/api/student');

    final url = ConectionHost.myUrl('/api/student/register/byStudent', {});

    final resp = await http.post(url, headers: headers, body: student.toJson());
    final respBody = json.decode(resp.body);

    print(respBody);

    status = false;
    ChangeNotifier();
  }

  Future updateStudent(StudentByResgister student, String id) async {
    String? token = await storage.read(key: 'token');

    Map<String, String> headers = {
      'content-type': 'application/json',
      'x-token': token!
    };

    status = true;
    ChangeNotifier();

    // final url = Uri.http(baseUrl, '/api/student');

    final url = ConectionHost.myUrl('/api/student/controlSchool/$id', {});

    final resp = await http.put(url, headers: headers, body: student.toJson());
    final respBody = json.decode(resp.body);

    print(respBody);

    status = false;
    ChangeNotifier();
  }
}
