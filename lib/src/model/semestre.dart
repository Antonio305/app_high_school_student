// To parse this JSON data, do
//
//     final semestres = semestresFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Semestres> semestresFromJson(String str) => List<Semestres>.from(json.decode(str).map((x) => Semestres.fromJson(x)));

String semestresToJson(List<Semestres> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Semestres {
    String name;
    String periodic;
    bool cursando;
    String uid;

    Semestres({
        required this.name,
        required this.periodic,
        required this.cursando,
        required this.uid,
    });

    Semestres copyWith({
        String? name,
        String? periodic,
        bool? cursando,
        String? uid,
    }) => 
        Semestres(
            name: name ?? this.name,
            periodic: periodic ?? this.periodic,
            cursando: cursando ?? this.cursando,
            uid: uid ?? this.uid,
        );

    factory Semestres.fromJson(Map<String, dynamic> json) => Semestres(
        name: json["name"],
        periodic: json["periodic"],
        cursando: json["cursando"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "periodic": periodic,
        "cursando": cursando,
        "uid": uid,
    };
}
