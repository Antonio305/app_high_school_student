import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prepa_estudiantes/services/semestres_services.dart';
import 'package:prepa_estudiantes/services/subject_services.dart';
import 'package:prepa_estudiantes/src/model/semestre.dart';

import '../model/subjects.dart';

class ScreemAddSemestreSubject extends StatefulWidget {
  const ScreemAddSemestreSubject({Key? key}) : super(key: key);

  @override
  State<ScreemAddSemestreSubject> createState() =>
      _ScreemAddSemestreSubjectState();
}

class _ScreemAddSemestreSubjectState extends State<ScreemAddSemestreSubject> {
  // create object  de type List<Semestres>
  List<Semestres> semestres = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // onLoadinSemestre();

    // final semestreServices =
    // Provider.of<SemestreServices>(context, listen: false);
    // semestres = semestreServices.semestres;
    // setState(() {

    // });
  }

  List<Subjects> subjects = [];

  // variable para alamcenar el ids del semestres
  String? idSemestreSelected;

  // funcion que retorna el id de las materias
  Future<List<String>> listIdSubjects(List<Subjects> subjects) async {
    List<String> newListIdSubjects = [];
    for (var index = 0; index < subjects.length; index++) {
      newListIdSubjects.add(subjects[index].uid);
    }
    return newListIdSubjects;
  }

  // int index
  int indexSelected = 0;

  @override
  Widget build(BuildContext context) {
    // final subjectServices =
    //       Provider.of<SubjectServices>(context, listen: false);

    final semestreServices =
        Provider.of<SemestreServices>(context, listen: true);
    semestres = semestreServices.semestres;

    final subjectServices = Provider.of<SubjectServices>(context);
    subjects = subjectServices.subjects;
    Color colorText = Colors.white60;

    return Scaffold(
      backgroundColor: const Color(0xff1C1D21),
      appBar: AppBar(
        backgroundColor: const Color(0xff1C1D21),
        centerTitle: true,
        title: Text(
          'Semestre y materia',
          style: TextStyle(color: colorText, fontSize: 20),
        ),
      ),
      body: Container(
        // color: Colors.redAccent
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center, para el lado vertical
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text('Seleciona un semestre',
                  style: TextStyle(color: colorText, fontSize: 17)),
            ),
            const SizedBox(
              height: 20,
            ),

            _listSemester(context, colorText),
            _listSubjects(subjectServices)
            // TextButton(onPressed: (), child: Text('S')),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            List<String> listIdSubject = await listIdSubjects(subjects);

            final semestreServices =
                Provider.of<SemestreServices>(context, listen: false);

            if (listIdSubject.isEmpty || idSemestreSelected == null) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentTextStyle: const TextStyle(fontSize: 20),
                    content: const Text(
                        'Seleciona tu lista de materias, antes de guarda...'),
                    actionsAlignment: MainAxisAlignment.center,
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Aceptar'))
                    ],
                  );
                },
              );

              return null;
            }
            List<String> idsSemestre = [];
            idsSemestre.add(idSemestreSelected!);

            String? data =
                await semestreServices.addSemestreByStudent(idsSemestre);
            String? resp =
                await subjectServices.addSubjectByStudent(listIdSubject);

            if (resp != null) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentTextStyle: const TextStyle(fontSize: 20),
                    content: Text(resp),
                    actionsAlignment: MainAxisAlignment.center,
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Aceptar'))
                    ],
                  );
                },
              );
            }
            // Navigator.pushNamed(context, 'add_semestre_subject');
          },
          // ignore: prefer_const_literals_to_create_immutables
          label: subjectServices.status
              ? Row(
                  children: const [
                    Text('CARGANDO ....'),
                    SizedBox(
                      width: 20,
                    ),
                    CircularProgressIndicator(
                      strokeWidth: 2,
                      value: 0.8,
                      color: Colors.white,
                      semanticsLabel: 'no se que pone',
                    )
                  ],
                )
              : const Text('GUARDAR SEMESTRE Y MATERIAS')),
    );
  }

  

  Flexible _listSubjects(SubjectServices subjectServices) {
    return Flexible(
      child: Container(
        // color: Colors.blue,
        child: subjects.isEmpty
            ? const Center(
                child: Text('Seleciona  un semestre para tu lista de materias'))
            : Center(
                child: subjectServices.statusAllSubject
                    ? const CircularProgressIndicator()
                    : Wrap(
                        children: List.generate(
                          subjects.length,
                          (index) => Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ActionChip(
                              label: Text(subjects[index].name),
                              // avatar: CircleAvatar(
                              //   child: Text(subjects[index]
                              //       .teachers
                              //       .name
                              //       .substring(0, 1)),
                              // ),
                              padding: const EdgeInsets.all(5),
                              onPressed: () {
                                // Navigator.pushNamed(
                                //     context, 'show_subjects',
                                //     arguments: subjects[index]);
                              },
                            ),
                          ),
                          // ListTile(
                          //   onTap: () {},
                          //   title: Text(subjects[index].name),
                          //   leading: CircleAvatar(
                          //     child: Text(subjects[index]
                          //         .teachers
                          //         .name
                          //         .substring(0, 1)),
                          //   ),
                          //   trailing:
                          //       const Icon(Icons.chevron_right_rounded),
                          // ),
                        ),
                      ),
              ),
      ),
    );
  }

  Padding _listSemester(BuildContext context, Color colorText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SizedBox(
        // child: Container(
        // color: Colors.red,
        // height: 40,
        child: Wrap(
          // physics: const BouncingScrollPhysics(),
          // scrollDirection: Axis.horizontal,
          children: List.generate(
            semestres.length,
            (index) {
              return TextButton(
                onPressed: () {
                  setState(() {
                    idSemestreSelected = semestres[index].uid;
                    indexSelected = index;
                  });

                  final subjectServices =
                      Provider.of<SubjectServices>(context, listen: false);
                  subjectServices.allSubjectForSemestre(semestres[index].uid);
                },
                style: TextButton.styleFrom(
                  backgroundColor:
                      index == indexSelected ? Colors.red : Colors.transparent,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
                child: Text(semestres[index].name,
                    style: TextStyle(color: colorText)),
              );
            },
          ),
        ),
      ),
    );
  }

  // Para cargar la lsita de los semestres
  // void onLoadinSemestre() async {
  //   final semestreServices =
  //       Provider.of<SemestreServices>(context, listen: false);
  //   semestres = await semestreServices.getSemestres();
  // }
}
