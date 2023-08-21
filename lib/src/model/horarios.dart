// To parse this JSON data, do
//
//     final horarios = horariosFromJson(jsonString);

import 'dart:convert';

class Horarios {
  Horarios({
    required this.schoolYear,
    required this.semestre,
    required this.group,
    required this.hours,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.uid,
  });

  SchoolYear schoolYear;
  GroupHorarios semestre;
  GroupHorarios group;
  List<String> hours;
  List<GroupHorarios> monday;
  List<GroupHorarios> tuesday;
  List<GroupHorarios> wednesday;
  List<GroupHorarios> thursday;
  List<GroupHorarios> friday;
  String uid;

  factory Horarios.fromRawJson(String str) =>
      Horarios.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Horarios.fromJson(Map<String, dynamic> json) => Horarios(
        schoolYear: SchoolYear.fromJson(json["schoolYear"]),
        semestre: GroupHorarios.fromJson(json["semestre"]),
        group: GroupHorarios.fromJson(json["group"]),
        hours: List<String>.from(json["hours"].map((x) => x)),
        monday: List<GroupHorarios>.from(
            json["monday"].map((x) => GroupHorarios.fromJson(x))),
        tuesday: List<GroupHorarios>.from(
            json["tuesday"].map((x) => GroupHorarios.fromJson(x))),
        wednesday: List<GroupHorarios>.from(
            json["wednesday"].map((x) => GroupHorarios.fromJson(x))),
        thursday: List<GroupHorarios>.from(
            json["thursday"].map((x) => GroupHorarios.fromJson(x))),
        friday: List<GroupHorarios>.from(
            json["friday"].map((x) => GroupHorarios.fromJson(x))),
        uid: json["uid"],
      );
      

  Map<String, dynamic> toJson() => {
        "schoolYear": schoolYear.toJson(),
        "semestre": semestre.toJson(),
        "group": group.toJson(),
        "hours": List<dynamic>.from(hours.map((x) => x)),
        "monday": List<dynamic>.from(monday.map((x) => x.toJson())),
        "tuesday": List<dynamic>.from(tuesday.map((x) => x.toJson())),
        "wednesday": List<dynamic>.from(wednesday.map((x) => x.toJson())),
        "thursday": List<dynamic>.from(thursday.map((x) => x.toJson())),
        "friday": List<dynamic>.from(friday.map((x) => x.toJson())),
        "uid": uid,
      };
}

class GroupHorarios {
  GroupHorarios({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory GroupHorarios.fromRawJson(String str) =>
      GroupHorarios.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GroupHorarios.fromJson(Map<String, dynamic> json) => GroupHorarios(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

class SchoolYear {
  SchoolYear({
    required this.id,
    required this.initialDate,
    required this.finalDate,
  });

  String id;
  DateTime initialDate;
  DateTime finalDate;

  factory SchoolYear.fromRawJson(String str) =>
      SchoolYear.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SchoolYear.fromJson(Map<String, dynamic> json) => SchoolYear(
        id: json["_id"],
        initialDate: DateTime.parse(json["initialDate"]),
        finalDate: DateTime.parse(json["finalDate"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "initialDate": initialDate.toIso8601String(),
        "finalDate": finalDate.toIso8601String(),
      };
}
