// To parse this JSON data, do
//
//     final subjects = subjectsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Subjects {
    String name;
    Teachers teachers;
    Semestre semestre;
    String uid;

    Subjects({
        required this.name,
        required this.teachers,
        required this.semestre,
        required this.uid,
    });

    factory Subjects.fromRawJson(String str) => Subjects.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Subjects.fromJson(Map<String, dynamic> json) => Subjects(
        name: json["name"],
        teachers: Teachers.fromJson(json["teachers"]),
        semestre: Semestre.fromJson(json["semestre"]),
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "teachers": teachers.toJson(),
        "semestre": semestre.toJson(),
        "uid": uid,
    };
}

class Semestre {
    String id;
    String name;

    Semestre({
        required this.id,
        required this.name,
    });

    factory Semestre.fromRawJson(String str) => Semestre.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Semestre.fromJson(Map<String, dynamic> json) => Semestre(
        id: json["_id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
    };
}

class Teachers {
    String id;
    String name;
    String lastName;
    String secondName;
    String gender;
    String collegeDegree;
    String typeContract;
    bool status;
    String rol;
    String tuition;
    String password;
    int v;

    Teachers({
        required this.id,
        required this.name,
        required this.lastName,
        required this.secondName,
        required this.gender,
        required this.collegeDegree,
        required this.typeContract,
        required this.status,
        required this.rol,
        required this.tuition,
        required this.password,
        required this.v,
    });

    factory Teachers.fromRawJson(String str) => Teachers.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Teachers.fromJson(Map<String, dynamic> json) => Teachers(
        id: json["_id"],
        name: json["name"],
        lastName: json["lastName"],
        secondName: json["secondName"],
        gender: json["gender"],
        collegeDegree: json["collegeDegree"],
        typeContract: json["typeContract"],
        status: json["status"],
        rol: json["rol"],
        tuition: json["tuition"],
        password: json["password"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "lastName": lastName,
        "secondName": secondName,
        "gender": gender,
        "collegeDegree": collegeDegree,
        "typeContract": typeContract,
        "status": status,
        "rol": rol,
        "tuition": tuition,
        "password": password,
        "__v": v,
    };
}
