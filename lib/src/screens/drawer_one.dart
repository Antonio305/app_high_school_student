import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prepa_estudiantes/services/horario_services.dart';
import 'package:prepa_estudiantes/services/student_services.dart';
import 'package:prepa_estudiantes/src/widgets/material_button.dart';

import 'dart:io';

import 'package:prepa_estudiantes/src/widgets/show_alert.dart';

class Drawer1 extends StatefulWidget {
  const Drawer1({Key? key}) : super(key: key);

  @override
  State<Drawer1> createState() => _Drawer1State();
}

class _Drawer1State extends State<Drawer1> {
  @override
  Widget build(BuildContext context) {
    const style1 = TextStyle(fontSize: 14, color: Colors.white70);
    final size = MediaQuery.of(context).size;

    return Drawer(
      width: Platform.isAndroid || Platform.isIOS
          ? size.width * 0.8
          : size.width * 0.25,
      child: Container(
        width: double.infinity,
        color: const Color(0xff1C1D21),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Profile(style1: style1),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    color: Colors.white70,
                    height: 1,
                    width: double.infinity,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ButtonOptions(
                      icon: Icons.chat_bubble_outline,
                      onPressed: () {
                        Navigator.pushNamed(context, 'chat');
                      },
                      text: 'Chat'),
                  const SizedBox(
                    height: 15,
                  ),
                  ButtonOptions(
                      icon: Icons.class_outlined,
                      onPressed: () async {
                        final student = Provider.of<StudentServices>(context,
                            listen: false);
                        final dataStudent = student.student;
                        final horarioServices = Provider.of<HorarioServices>(
                            context,
                            listen: false);

                        horarioServices.getHorario(
                            // '63f96704cfe1982933912129',
                            dataStudent.generation.id,
                            dataStudent.semestre.last.id,
                            dataStudent.group.id);

                        Navigator.pushNamed(context, 'classes');

                        // ShowAlert.showAlert(
                        //   context,
                        //   'SELECCIONA EL SEMESTRE',
                        //   Wrap(
                        //       children: List.generate(
                        //     dataStudent.semestre.length,
                        //     (index) {
                        //       return OutlinedButton(
                        //           onPressed: () async {
                        //             await horarioServices.getHorario(
                        //                 // '63f96704cfe1982933912129',
                        //                 dataStudent.generation.id,
                        //                 dataStudent.semestre[index].id,
                        //                 // '63f96554b7d6aa73186782a1',
                        //                 // dataStudent.semestre.first.id,
                        //                 dataStudent.group.id
                        //                 // '63f95ec9723de0c9e3bdf3b1'
                        //                 );
                        //             Navigator.pop(context);
                        //             Navigator.pushNamed(context, 'class');

                        //             print('Hola futureo mask suckerveco');
                        //           },
                        //           child:
                        //               Text(dataStudent.semestre[index].name));
                        //     },
                        //   )),
                        // );
                        // horarioServices.getHorario(
                        //     dataStudent.generation.id,
                        //     '63f96554b7d6aa73186782a1',
                        //     // dataStudent.semestre.first.id,
                        //     dataStudent.group.id);

                        // Navigator.pushNamed(context, 'class');
                      },
                      text: 'Horarios'),
                  const SizedBox(
                    height: 15,
                  ),
                  // ButtonOptions(
                  //     icon: Icons.expand_more_sharp,
                  //     onPressed: () {
                  //       Navigator.pushNamed(context, 'exams');
                  //     },
                  //     text: 'Examanes'),
                      ButtonOptions(
                      icon: Icons.subject_outlined,
                      onPressed: () {
                        Navigator.pushNamed(context, 'subjects');
                      },
                      text: 'Materias'),
                  const SizedBox(
                    height: 15,
                  ),
                  ButtonOptions(
                      icon: Icons.person_off_outlined,
                      onPressed: () {
                        Navigator.pushNamed(context, 'list_teachers');
                      },
                      text: 'Profesores'),
                  const SizedBox(height: 15),
                  ButtonOptions(
                    onPressed: () {
                      Navigator.pushNamed(context, 'rating');
                    },
                    text: 'Calificaciones',
                    icon: Icons.rate_review_outlined,
                  ),
                  const SizedBox(height: 30),
                  Container(
                    color: Colors.white70,
                    height: 1,
                    width: double.infinity,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ButtonOptions(
                      icon: Icons.settings,
                      onPressed: () {},
                      text: 'Configuracion'),
                  const SizedBox(
                    height: 15,
                  ),
                  ButtonOptions(
                      icon: Icons.help, onPressed: () {}, text: 'Ayuda'),
                  const SizedBox(
                    height: 30,
                  ),
                  const Center(
                      child: Text(
                    ' Rafael Pascacio Gamboa',
                    style: style1,
                  )),
                ]),
          ),
        ),
      ),
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({
    Key? key,
    required this.style1,
  }) : super(key: key);

  final TextStyle style1;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final studentServices = Provider.of<StudentServices>(context);
    final student = studentServices.student;

    return GestureDetector(
      onTap: () {
        // intanice loginServices for token
        // final loginServices = LoginServices();
        // // Provider.of<LoginServices>(context, listen: false);

        // String? token = await loginServices.myTokenID();

        // final studentServides =
        //     Provider.of<StudentServices>(context, listen: false);

        // await studentServides.getStudentForID(token!);
        Navigator.pushNamed(context, 'profile');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  "https://imagesvc.meredithcorp.io/v3/mm/image?url=https:%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2020%2F02%2Fkatherine-johnson.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(student.name + "  " + student.lastName + "" + student.secondName,
              style: widget.style1),
          Text(
            'hitler_aleman@gmail.com',
            style: widget.style1,
          ),
        ],
      ),
    );
  }
}
