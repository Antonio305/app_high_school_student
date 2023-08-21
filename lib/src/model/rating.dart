import 'dart:convert';

class Ratings {
  Ratings({
    required this.id,
    required this.student,
    required this.semestre,
    required this.subject,
    required this.parcial1,
    required this.parcial2,
    required this.parcial3,
    required this.semesterGrade,
    required this.v,
  });

  String id;
  String student;
  String semestre;
  String subject;
  double parcial1;
  double parcial2;
  double parcial3;
  double semesterGrade;
  int v;

  factory Ratings.fromRawJson(String str) => Ratings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ratings.fromJson(Map<String, dynamic> json) => Ratings(
        id: json["_id"],
        student: json["student"],
        semestre: json["semestre"],
        subject: json["subject"],
        parcial1: json["parcial1"].toDouble(),
        parcial2: json["parcial2"].toDouble(),
        parcial3: json["parcial3"].toDouble(),
        semesterGrade: json['semesterGrade'].toDouble(),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "student": student,
        "semestre": semestre,
        "subject": subject,
        "parcial1": parcial1,
        "parcial2": parcial2,
        "parcial3": parcial3,
        'semesterGrade': semesterGrade,
        "__v": v,
      };
}
