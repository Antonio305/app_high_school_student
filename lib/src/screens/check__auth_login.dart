import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prepa_estudiantes/services/student_services.dart';
import 'package:prepa_estudiantes/services/subject_services.dart';
import 'package:prepa_estudiantes/services/task_services.dart';
import 'package:prepa_estudiantes/src/model/subjects.dart';
import 'package:prepa_estudiantes/src/screens/home.dart';

import '../../services/chat/socket_servives.dart';
import '../../services/login_services.dart';
import '../../services/story_services.dart';
import '../model/student.dart';
import 'home.dart';
import 'login.dart';

class CheckAuthScreen extends StatefulWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  State<CheckAuthScreen> createState() => _CheckAuthScreenState();
}

class _CheckAuthScreenState extends State<CheckAuthScreen> {
// function that returs the list Of Object Ids of the  subject

  // Future<List<String>>
  listIdSubject(List<Subjects> listIdSubjects) {
// new id list
    List<String> newIdList = [];

    for (var idSuject in listIdSubjects) {
      newIdList.add(idSuject.uid);
    }

    return newIdList;
  }

  @override
  Widget build(BuildContext context) {
    // hacemos ka instnacia del login para la validacion
    // final loginServices = Provider.of<LoginServices>(context, listen: false);
    final loginServices = Provider.of<LoginServices>(context);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          // future: loginServices.readToken(),
          future: checkLoginState(context),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            // builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

            // shanpshot guarda el dato que retorna el el future

            if (!snapshot.hasData) return const Text('Espere');

            // Future.Microtask es para esperar que se recostruya todo el widget que se  mostrara a continucacio
            if (snapshot.data == '') {
              Future.microtask(() {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const Login(),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              });
            } else {
              Future.microtask(() async {
                final studentServices =
                    Provider.of<StudentServices>(context, listen: false);
                final loginServices = LoginServices();
                final String token = await loginServices.readToken();

                await studentServices.getStudentForID(token);

                final student = studentServices.student;

                // paras las tareas
                final taskServices =
                    Provider.of<TaskServices>(context, listen: false);

                // para  obtener la lista de materia
                final subjectServices =
                    Provider.of<SubjectServices>(context, listen: false);

                await subjectServices
                    .allSubjectForSemestre(student.semestre.last.id);

                final subjects = subjectServices.subjects;

                // final idSubjects = listIdSubject(student.subjects);
                final idSubjects = listIdSubject(subjects);

                final storyServices =
                    Provider.of<StoryServices>(context, listen: false);
                await storyServices.getAllStoryByStatusTrue();

                await taskServices.getTaskStudent(
                    // token,
                    student.generation.id,
                    student.semestre[0].id,
                    student.group.id,
                    // student.subjects[1].id
                    idSubjects);

                // para conectar el socket
                final socketS =
                    Provider.of<SocketService>(context, listen: false);
                socketS.connect();

                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const Home(),
                        transitionDuration: const Duration(seconds: 0)));

                //  Navigator.of(context).pushReplacementNamed('home');
              });
            }

            // return Container();

            return const Text('Espere');
          },
        ),
      ),
    );
  }

// FUNCIN PARA LA VALIDACION  DEL TOKEN
  Future checkLoginState(BuildContext context) async {
    final loginServices = Provider.of<LoginServices>(context, listen: false);
    // final String? token = await loginServices.storage.read(key: 'token');
    // final String? token = await loginServices.readToken();
    final String? token = await loginServices.readToken();

/**
 * primero validar si hay token
 * segundo verificar si sigue vigente
 */

    if (token != null) {
      // verificdar si el token aun es valido, si es valido navager al home
      bool isValidateToken = await loginServices.validateToken(token);
      if (isValidateToken == false) {
        await loginServices.logout();
        Future.microtask(() {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const Login(),
              transitionDuration: const Duration(seconds: 0),
            ),
          );
        });

        // showDialog(
        //     builder: (BuildContext context) {
        //       return AlertDialog(
        //         title: const Text('Sesion expirada'),
        //         content: const Text(
        //             'Su sesion se ha expirado. Por favor inicia sesion de nuev.'),
        //         actions: [
        //           TextButton(
        //               onPressed: () {
        //                 Future.microtask(() {
        //                   Navigator.pushReplacement(
        //                     context,
        //                     PageRouteBuilder(
        //                       pageBuilder: (_, __, ___) => const Login(),
        //                       transitionDuration: const Duration(seconds: 0),
        //                     ),
        //                   );
        //                 });
        //               },
        //               child: const Text('Aceptar'))
        //         ],
        //       );
        //     },
        //     context: context);
      }
      // si el token es valido ir al home
      else {
        Future.microtask(() async {
          final studentServices =
              Provider.of<StudentServices>(context, listen: false);
          final loginServices = LoginServices();
          final String token = await loginServices.readToken();

          await studentServices.getStudentForID(token);

          final student = studentServices.student;

          // paras las tareas
          final taskServices =
              Provider.of<TaskServices>(context, listen: false);

          // para  obtener la lista de materia
          final subjectServices =
              Provider.of<SubjectServices>(context, listen: false);

          await subjectServices.allSubjectForSemestre(student.semestre.last.id);

          final subjects = subjectServices.subjects;

          // final idSubjects = listIdSubject(student.subjects);

          final idSubjects = listIdSubject(subjects);

          final storyServices =
              Provider.of<StoryServices>(context, listen: false);

          // await storyServices.getAllStoryByStatusTrue();

// esto esta fallando

          // await taskServices.getTaskStudent(
          //     // token,
          //     student.generation.id,
          //     student.semestre[0].id,
          //     student.group.id,
          //     // student.subjects[1].id
          //     idSubjects);

          // para conectar el socket
          final socketS = Provider.of<SocketService>(context, listen: false);
          await socketS.connect();

          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const Home(),
                  transitionDuration: const Duration(seconds: 0)));

          //  Navigator.of(context).pushReplacementNamed('home');
        });
      }
    } else {
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const Login(),
            transitionDuration: const Duration(seconds: 0),
          ),
        );
      });
    }
  }
}
