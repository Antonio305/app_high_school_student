import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prepa_estudiantes/services/chat/chat_services.dart';
import 'package:prepa_estudiantes/services/subject_services.dart';
import 'package:prepa_estudiantes/src/widgets/card_chat.dart';

import '../../services/student_services.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // onLoading();
  }

  // Liata de los profesores
  @override
  Widget build(BuildContext context) {
    final subjectServices = Provider.of<SubjectServices>(context);

    final subjects = subjectServices.subjects;
    final studentServices =
        Provider.of<StudentServices>(context, listen: false);

    return Scaffold(
            backgroundColor: const Color(0xff1C1D21),

      appBar: AppBar(
        title: const Text('Docentes'),
        centerTitle: true,
        backgroundColor: const Color(0xff1C1D21),
      ),
      body: SafeArea(
        child: studentServices.student.subjects.isEmpty
            ? Center(
                child: SizedBox(
                  height: 150,
                  child: Card(
                    color: const Color(0xff25282F),
                    child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('No tienes materias agregadas'),
                              const SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, 'add_semestre_subject');
                                  },
                                  child: const Text('Agregar materias')),
                            ],
                          ),
                        )),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                    children: List.generate(subjects.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      final chatServices =
                          Provider.of<ChatServices>(context, listen: false);
                      // chatServices.getMessage(users.uid);

                      chatServices.userPara = subjects[index].teachers;

                      Navigator.pushNamed(context, 'chat_message');
                    },
                    child: CardChat(
                        // image: teachers[index].image,
                        image:
                            "https://pyxis.nymag.com/v1/imgs/2e0/38e/55f0d4724239a2b0aae4930e8b2e5d7c27-14-stephen-hawking.rsquare.w700.jpg",
                        materia: subjects[index].name,
                        name: subjects[index].teachers.name +
                            " " +
                            subjects[index].teachers.lastName
                        // +
                        // " " +
                        // subjects[index].teachers.secondName
                        ),
                  );
                })),
              ),
      ),
    );
  }

  void onLoading() async {
    final studentServices =
        Provider.of<StudentServices>(context, listen: false);

    final subjectServices =
        Provider.of<SubjectServices>(context, listen: false);
    final student = studentServices.student;

    final subjects = subjectServices.subjects;

    if (studentServices.student.subjects.isEmpty) {
      await subjectServices.allSubjectForSemestre(student.semestre.last.id);
    }
  }
}

class Teachers {
  int? id;
  String name = "";
  String materia = "";
  String image = "";
  // cremos el contructor

  Teachers(int id, String names, String materias, String images) {
    id = id;
    name = names;
    materia = materias;
    image = images;
  }
}
