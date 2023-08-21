import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prepa_estudiantes/services/student_services.dart';

import '../../services/semestres_services.dart';
import '../../services/subject_services.dart';
import '../../services/taskReceived_services.dart';
import '../../services/task_services.dart';
import '../model/subjects.dart';
import '../model/task.dart';

class ScreenlistSUbjects extends StatelessWidget {
  const ScreenlistSUbjects({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
// instancia de la clase para las tareas
    final taskServices = Provider.of<TaskServices>(context);
    final List<Tasks> tasks = taskServices.tasks;

// instnaciadel model dende esta el datos de los estudianes
    final studentServices = Provider.of<StudentServices>(context);
    final student = studentServices.student;

    // nistacne class para mostar la lista de materia
    final subjectServices = Provider.of<SubjectServices>(context);

    final subjects = subjectServices.subjects;

    // show list semestres
    final semestres = studentServices.student.semestre;
    Color colorText = Colors.white60;

    return Scaffold(
      backgroundColor: const Color(0xff1C1D21),
      appBar: AppBar(
        backgroundColor: const Color(0xff1C1D21),
        centerTitle: true,
        title: Text(
          'Materias',
          style: TextStyle(color: colorText),
        ),
      ),
      body: Container(
        // color: Colors.red,
        child: Column(
          children: [
            Flexible(
                child: ListView(
// reverse:  true,
              children: List.generate(
                semestres.length,
                (index) => ListTile(
                  title: Text(
                    semestres[index].name,
                    style: TextStyle(color: colorText),
                  ),
                  subtitle: Text(semestres[index].periodic),
                  autofocus: true,
                  onTap: () async {
                    // cargar las materias por el semestre
                    // final subjectServices =
                    //     Provider.of<SubjectServices>(context, listen: false);
                    subjectServices.allSubjectForSemestre(semestres[index].id);

//                  subjectServices.statusAllSubject == true
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(semestres[index].name),
                          content:
                              //  subjectServices.statusAllSubject == false
                              // ? const CircularProgressIndicator()
                              // :
                              SizedBox(child: ListSubjects(subjects: subjects)),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Salir'),
                            ),
                          ],
                          actionsAlignment: MainAxisAlignment.spaceAround,
                        );
                      },
                    );
                  },
                  leading: CircleAvatar(child: Text(index.toString())),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.chevron_right_rounded)),
                ),
              ),
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            final semestreServices =
                Provider.of<SemestreServices>(context, listen: false);
            semestreServices.getSemestres();

            Navigator.pushNamed(context, 'add_semestre_subject');
          },
          label: const Text('Agregar Semestre y Materia')),
    );
  }
}

class ListSubjects extends StatelessWidget {
  const ListSubjects({
    Key? key,
    required this.subjects,
  }) : super(key: key);

  final List<Subjects> subjects;

  @override
  Widget build(BuildContext context) {
    final studentServices = Provider.of<StudentServices>(context);
    final student = studentServices.student;

    final subServices = Provider.of<SubjectServices>(context);

    final subjects = subServices.subjects;
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height / 2.3,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          const Text(
            'Materias',
            style: TextStyle(fontSize: 18, color: Colors.white70),
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
          Flexible(
            child: Center(
              child: subServices.statusAllSubject == true
                  ? const CircularProgressIndicator()
                  : Wrap(
                      children: List.generate(subjects.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              // backgroundColor:    Color(0xff25282F),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xff25282F)),
                            ),
                            onPressed: () async {
                              // Befor navigating     the next view make   two request by subject
                              // taks for subject
                              // and task qualified

                              final taskServices = Provider.of<TaskServices>(
                                  context,
                                  listen: false);

                              final taskQualifieldServices =
                                  Provider.of<TaskQualifieldServices>(context,
                                      listen: false);

                              // get task for subject
                              taskServices.getTaskStentBySubject(
                                  student.group.id, subjects[index].uid);

                              // / esto extrae todas las tareas en la cuall
                              //   //solo se require por materia
                              taskQualifieldServices.getAllTaskReceivedBySubjet(
                                  subjects[index].uid);
                              // taskQualifieldServices.getAllTaskReceived(idStudent);

                              Navigator.pushNamed(context, 'show_subjects',
                                  arguments: subjects[index]);
                            },
                            child: Text(subjects[index].name),
                          ),
                        );
                      }),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
