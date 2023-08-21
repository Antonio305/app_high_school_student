import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prepa_estudiantes/services/task_services.dart';
import 'package:prepa_estudiantes/src/model/subjects.dart';
import 'package:prepa_estudiantes/src/screens/home.dart';
import 'package:prepa_estudiantes/src/widgets/cardTask_qualifield.dart';

import '../../services/taskReceived_services.dart';
import '../model/task.dart';
import '../model/task_received.dart';

class ScreenSubject extends StatefulWidget {
  const ScreenSubject({Key? key}) : super(key: key);

  @override
  State<ScreenSubject> createState() => _ScreenSubjectState();
}

class _ScreenSubjectState extends State<ScreenSubject> {
// OBJECT OF TYPE LIST  STORE  THE TASK LIST
// OBJETO PARA ALMCENARLA LISTA DE TAREAS

  List<Tasks> task = [];

// object of type list store the task qualified list
  List<Tasks> taskqualified = [];

  @override
  Widget build(BuildContext context) {
    /**
      * LA INFORMACION DE LA  MATERIA SE RECIVE COMO PARAMETRO
      * THE INFORMATION OF THE SUBJECT IS RECEIVED AS A PARAMETER
      */
    Subjects subject = ModalRoute.of(context)?.settings.arguments as Subjects;

    final taskServices = Provider.of<TaskServices>(context);
    final size = MediaQuery.of(context).size;
    final taskQualifieldServices = Provider.of<TaskQualifieldServices>(context);
    final taskQualifield = taskQualifieldServices.taskQualifieldBySubject;

    // final tasks = taskServices.tasks;

    final tasks = taskServices.tasksBySubject;

    final style1 = const TextStyle(color: Colors.white60, fontSize: 20);

    return Scaffold(
        backgroundColor: const Color(0xff1C1D21),
        appBar: AppBar(
          centerTitle: true,
          title: Text(subject.name),
          backgroundColor: const Color(0xff1C1D21),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _subjectDate(size, subject, style1),
              const SizedBox(
                height: 20,
              ),
              Card(
                color: const Color(0xff242529),
                borderOnForeground: true,
                elevation: 1,
                child: SizedBox(
                  height: 100,
                  width: 350,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [Text('Entregado'), Text('20')],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [Text('Fa lta por entregar'), Text('20')],
                      ),
                    ],
                  ),
                ),
              ),
              _listTaskBySubject(tasks, taskServices),
              _listTaskBySubjectQualifield(taskQualifield)
            ],
          ),
        ));
  }

  SizedBox _listTaskBySubject(List<Tasks> tasks, TaskServices taskServices) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text('Tareas'),
          ),
          const SizedBox(
            height: 5,
          ),
          taskServices.status == true
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  height: 220,
                  child: tasks.isEmpty
                      ? Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(width: 0.5, color: Colors.white10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.asset('asset/mitask.png')),
                              const Text("Vendito sea el señor no tienes tarea",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white70)),
                            ],
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: tasks.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, 'home_tarea',
                                      arguments: tasks[index]);
                                },
                                child: CardTarea(tasks: tasks[index]));
                          },
                        ),
                ),
        ],
      ),
    );
  }

  SizedBox _listTaskBySubjectQualifield(List<TaskReceived> tasksQualifield) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text('Tareas Calificados'),
          ),
          SizedBox(
            height: 200,
            child: taskqualified.isEmpty
                ? Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 0.5, color: Colors.white10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.asset('asset/mitask.png')),
                        const Text("NO TIENES TAREAS CALIFICADOS",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white70)),
                      ],
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: tasksQualifield.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {},
                        child: CardTaskQualifield(
                            taskReceived: tasksQualifield, index: index),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Container _subjectDate(Size size, Subjects subject, TextStyle style1) {
    return Container(
      height: size.height * .4,
      width: double.infinity,

      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
        color: Color.fromARGB(255, 20, 22, 27),
      ),

      // decoration: const BoxDecoration(
      //   borderRadius: BorderRadius.only(
      //       bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      //   color: Color(0xFF1D2027),
      // ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(subject.name, style: style1)),
          Text(subject.teachers.name, style: style1),
          Text(subject.semestre.name, style: style1),
        ],
      ),
    );
  }
}
