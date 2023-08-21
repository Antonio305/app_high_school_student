import 'package:flutter/material.dart';

import 'dart:io';

import 'package:provider/provider.dart';
import 'package:prepa_estudiantes/services/rating_services.dart';
import 'package:prepa_estudiantes/services/subject_services.dart';
import 'package:prepa_estudiantes/src/model/student.dart';

import '../../services/student_services.dart';
import '../model/subjects.dart';
import '../widgets/show_alert.dart';

class ScreenRating extends StatelessWidget {
  const ScreenRating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // final student = Provider.of<StudentServices>(context, listen :false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calificaciones'),
      ),
      body: Center(
        child: Card(
          elevation: 5,
          // color: Colors.red,
          child: MaterialButton(
            // color: Colors.blue,
            onPressed: () async {
              // await openDialogForMateri(context);
              Navigator.pop(context);
              dialogSelectedSemestre(context, size);
            },
            child: const Text('Seleccionar semestre semestre'),
          ),
        ),
      ),
    );
  }

  // for materia
  Future<String?> dialogSelectedSemestre(BuildContext context, Size size) =>
      showDialog<String>(
          context: context,
          builder: (context) {
            final student = Provider.of<StudentServices>(context);

            return Center(
              child: AlertDialog(
                content: SizedBox(
                  height: Platform.isWindows || Platform.isMacOS
                      ? size.height / 2
                      : size.height / 2,
                  width: Platform.isWindows || Platform.isMacOS
                      ? size.width / 2
                      : size.width,
                  // color: Colors.red,
                  child: Center(
                    child: Wrap(
                        children: List.generate(
                            student.student.semestre.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    // color: Colors.red,
                                    child: GestureDetector(
                                      onTap: () async {
                                        // Navigator.pop(context);
                                        Navigator.pop(context);

                                        _showDialogGetSubject(
                                            context, size, student);
                                        // Navigator.of(context).pop();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(student
                                            .student.semestre[index].name),
                                      ),
                                    ),
                                  ),
                                ))),
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          color: Colors.black,
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 35, right: 35),
                            child: Text('CANCELAR',
                                style: TextStyle(color: Colors.white)),
                          )),
                    ],
                  )
                ],
              ),
            );
          });

  // for materia
  Future<String?> _showDialogGetSubject(
          BuildContext context, Size size, StudentServices student) =>
      showDialog<String>(
          // barrierColor: Colors.red[200], // color de fondo del dialong
          context: context,
          builder: (context) {
            final subjectServices = Provider.of<SubjectServices>(context);
            final subjects = subjectServices.subjects;

            return Center(
              child: AlertDialog(
                contentPadding: const EdgeInsets.all(10),
                content: SizedBox(
                  height: Platform.isWindows || Platform.isMacOS
                      ? size.height / 2
                      : size.height / 1.5,
                  width: Platform.isWindows || Platform.isMacOS
                      ? size.width / 2
                      : size.width,
                  // color: Colors.red,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Wrap(
                        children: List.generate(
                          subjects.length,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                final ratingServices =
                                    Provider.of<RatingServices>(context,
                                        listen: false);

                                if (ratingServices.status == true) {
                                  print(
                                      ' buscando los datos de las calificaciones');
                                  void _showDialog(BuildContext context) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        // Cierra el diálogo después de 3 segundos
                                        // Future.delayed(Duration(seconds: 3),
                                        // () {
                                        if (!ratingServices.status) {
                                          Navigator.of(context).pop();
                                        }
                                        // });
                                        return AlertDialog(
                                          content: Column(
                                            children: const [
                                              Text("BUSCANDO...."),
                                              CircularProgressIndicator()
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }
                                }
                                String? message =
                                    await ratingServices.getRatingForMateria(
                                        student.student.uid!,
                                        subjects[index].uid);

                                if (message != null) {
                                  // mostramos un mensaje de erro indicando el menaje de la repues
                                  // al final no retornaremos nada
                                  print(message);
                                  ShowAlert.showAlert(
                                      context,
                                      'Calificaciones',
                                      Center(
                                        child: Text(message),
                                      ));
                                  return null;
                                }

                                _showDialogRating(
                                    context, size, subjects[index]);
                                // Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(subjects[index].name),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          // color: Colors.black,
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Text('CANCELAR',
                                style: TextStyle(color: Colors.white)),
                          )),
                    ],
                  )
                ],
              ),
            );
          });

  Future<String?> _showDialogRating(
          BuildContext context, Size size, Subjects subject) =>
      showDialog<String>(
          // barrierColor: Colors.red[200], // color de fondo del dialong
          context: context,
          builder: (context) {
            final gradesServices = Provider.of<RatingServices>(context);
            final grades = gradesServices.rating;

            return Center(
              child: AlertDialog(
                title: const Text('Calificaciones'),
                content: SizedBox(
                  height: size.height / 2,
                  // width: size.width / 2,
                  // color: Colors.red,
                  child: Center(
                    child: gradesServices.status == true
                        ? const CircularProgressIndicator()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(subject.name),
                              Wrap(runSpacing: 20, spacing: 40, children: [
                                Text('PARCIAL 1:  ' +
                                    grades.parcial1.toString()),
                                Text('PARCIAL 2:   ' +
                                    grades.parcial2.toString()),
                                Text('PARCIAL 3 :   ' +
                                    grades.parcial3.toString()),
                              ]),
                              Text('CALIFICACIO FINAL:  ' +
                                  grades.semesterGrade
                                      .toString()
                                      .substring(0, 3))
                            ],
                          ),
                  ),
                ),
                actions: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          // color: Colors.black,
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 35, right: 35),
                            child: Text('ACEPTAR',
                                style: TextStyle(color: Colors.white)),
                          )),
                    ],
                  )
                ],
              ),
            );
          });
}
