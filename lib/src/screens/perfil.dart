import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/student_services.dart';
import '../model/student.dart';

class ProfileStudents extends StatelessWidget {
  const ProfileStudents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final studentServices = Provider.of<StudentServices>(context);
    Student student = studentServices.student;

    // final Student student =
    //     ModalRoute.of(context)!.settings.arguments as Student;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Editar Informacion del estudiante"),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0XFF1d2027),
        // title: const Text('Datos del estudiante'),
      ),
      body: SafeArea(
          child: Platform.isWindows || Platform.isMacOS
              ? ContentWindowsMac(size: size, student: student)
              : ContenAndroidIos(size: size, student: student)),
    );
  }
}

class ContenAndroidIos extends StatefulWidget {
  const ContenAndroidIos({
    Key? key,
    required this.size,
    required this.student,
  }) : super(key: key);

  final Size size;
  final Student student;

  @override
  State<ContenAndroidIos> createState() => _ContenAndroidIosState();
}

class _ContenAndroidIosState extends State<ContenAndroidIos>
    with SingleTickerProviderStateMixin {
// para las animaciones del texto
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation = CurvedAnimation(parent: _controller!, curve: Curves.easeInOut);
    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      letterSpacing: 2,
      shadows: [
        Shadow(
          color: Colors.grey.withOpacity(0.5),
          offset: Offset(1, 1),
          blurRadius: 1,
        ),
      ],
    );
    return Container(
      width: widget.size.width,
      // height: size.height * 0.75,
      decoration: const BoxDecoration(
          // color: Colors.black12,
          // borderRadius: BorderRadius.horizontal(left: 8),
          // border: Border.all(color: Colors.black26, width: 0.5),
          ),
      child: SingleChildScrollView(
        child: Column(

            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              _image(size: widget.size, student: widget.student),

              const SizedBox(
                height: 20,
              ),

              Text('Datos del estudiante', style: textStyle),
              const SizedBox(
                height: 10,
              ),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(10),
                  // color: Colors.white24,
                  // color: Colors.black26
                  // color: Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      runSpacing: 10,
                      spacing: 40,
                      children: [
                        // Text(
                        //     'Nombre : ${student.name + "  " + student.lastName + "  " + student.secondName}'),
                        Text('Sexo:  ${widget.student.gender}'),
                        Text(
                            'Fecha Nacimiento:  ${widget.student.dateOfBirth}'),
                        Text('tipo de Sangre:  ${widget.student.bloodGrade}'),
                        Text('Crup: ${widget.student.curp}'),
                        Text('Edad:  ${widget.student.age}'),
                        Text('direccion: ${widget.student.town}'),
                        Text('Telefono: ${widget.student.numberPhone}'),
                        // Text('Telefono: ${widget.student.e}'),

                        Text('Matricula:  ${widget.student.tuition}'),
                      ]),
                ),
              ), //
              const SizedBox(height: 20),
              Text('Datos del tutor', style: textStyle),
              const SizedBox(height: 20),

// de chat  pgt
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(10),
                    // color: Colors.white24,
                    // color: Colors.black26
                    // color: Colors.transparent,
                  ),
                  width: widget.size.width,
                  // color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      runSpacing: 10,
                      spacing: 40,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.account_circle, size: 22.0),
                            const SizedBox(width: 8.0),
                            Text(
                                'Nombre:  ${widget.student.studentTutor.nameTutor + "  " + widget.student.studentTutor.lastNameTutor + "  " + widget.student.studentTutor.secondNameTutor}'),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.phone, size: 22.0),
                            const SizedBox(width: 8.0),
                            Text(
                                'Numero de telefono:  ${widget.student.studentTutor.numberPhoneTutor}'),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.family_restroom, size: 22.0),
                            const SizedBox(width: 8.0),
                            Text(
                                'Parentesco:  ${widget.student.studentTutor.kinship}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Datos escolares'),
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  width: widget.size.width,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  // color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.group),
                            const SizedBox(width: 8.0),
                            Text('Grupo:  ' + widget.student.group.name),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.school),
                            const SizedBox(width: 8.0),
                            const Text('Semestres: '),
                            const SizedBox(width: 8.0),
                            Wrap(
                              children: List.generate(
                                widget.student.semestre.length,
                                (index) =>
                                    Text(widget.student.semestre[index].name),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.date_range),
                            const SizedBox(width: 8.0),
                            Text('Generacion:  ' +
                                widget.student.generation.initialDate
                                    .toString()
                                    .substring(0, 10) +
                                ' - ' +
                                widget.student.generation.finalDate
                                    .toString()
                                    .substring(0, 10)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Text('Materias', style: textStyle),
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Wrap(
                    children: List.generate(
                        widget.student.subjects.length,
                        (index) => Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Chip(
                              label: Text(widget.student.subjects[index].name)),
                        ))),
              ),

              const SizedBox(height: 100),

              // const Spacer(),
              // MaterialButton(
              //     color: Colors.blue,
              //     child: const Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              //       child: Text('Editar'),
              //     ),
              //     onPressed: () {})
            ]),
      ),
    );
  }
}

class _image extends StatelessWidget {
  const _image({
    Key? key,
    required this.size,
    required this.student,
  }) : super(key: key);

  final Size size;
  final Student student;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
        // border: Border.all(color: Colors.black26, width: 0.5),
        color: Color(0xFF1D2027),
      ),

      width: size.width,
      height: 300,
      // width: 300,
      child: Column(
        children: [
          CircleAvatar(
            // backgroundImage: ,
            radius: 90.0,
            backgroundColor: Colors.blueAccent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(90),
              child: Image.network(
                'https://img.apmcdn.org/2e2ceb4fdbd8ac017b85b242fe098cb3b466cf5a/square/44315c-20161208-katherine-johnson.jpg',
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(height: 30),

          // name student
          Text(
            '${student.name + "  " + student.lastName}',

            // '${student.name + "  " + student.lastName + "  " + student.secondName}',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const Text('eldioseltreno@gmail.com',
              style: TextStyle(color: Colors.white60)),
        ],
      ),
    );
  }
}

class ContentWindowsMac extends StatelessWidget {
  const ContentWindowsMac({
    Key? key,
    required this.size,
    required this.student,
  }) : super(key: key);

  final Size size;
  final Student student;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.6,
      height: size.height * 0.75,
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black26, width: 0.5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Center(
                child: CircleAvatar(
                  radius: 90.0,
                  backgroundColor: Colors.black,
                  child: Container(),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: Colors.black,
                    // color: Colors.transparent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center ,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40)),
                              // border: Border.all(color: Colors.black26, width: 0.5),
                              color: Color(0xFF1D2027),
                            ),

                            width: size.width,
                            height: 300,
                            // width: 300,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  // backgroundImage: ,
                                  radius: 90.0,
                                  backgroundColor: Colors.blueAccent,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(90),
                                    child: Image.network(
                                      'https://img.apmcdn.org/2e2ceb4fdbd8ac017b85b242fe098cb3b466cf5a/square/44315c-20161208-katherine-johnson.jpg',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),

                                // name student
                                Text(
                                  //   '

                                  // ${student.name + "  " + student.lastName}

                                  //   ',

                                  '${student.name + "  " + student.lastName + "  " + student.secondName}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                const Text('eldioseltreno@gmail.com',
                                    style: TextStyle(color: Colors.white60)),
                              ],
                            ),
                          ),
                          // Text(
                          //     'Nombre : ${student.name + student.lastName + student.secondName}'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Sexo :${student.gender}'),
                              Text('Fecha Nacimiento: ${student.dateOfBirth}'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('tipo de Sangre : ${student.bloodGrade}'),
                              Text('Crup: ${student.curp}'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Edad : ${student.age}'),
                              Text('direccion: ${student.town}'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Telefono: ${student.numberPhone}'),
                              Text('Matricula ${student.tuition}'),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text('Datos del tutor'),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'Nombre: ${student.studentTutor.nameTutor + student.studentTutor.lastNameTutor + student.studentTutor.secondNameTutor}'),
                              Text(
                                  'Numero de telefono: ${student.studentTutor.numberPhoneTutor}'),
                              Text(
                                  'Parentesco : ${student.studentTutor.kinship}'),
                            ],
                          )
                        ]),
                  ),
                ),
              ), //

              const SizedBox(height: 50),

              // const Spacer(),
              MaterialButton(
                  color: Colors.blue,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: Text('Editar'),
                  ),
                  onPressed: () {})
            ]),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'dart:math' as math;
// import '../../services/login_services.dart';
// import '../../services/student_services.dart';
// import '../model/student.dart';

// class ProfileStudents extends StatefulWidget {
//   const ProfileStudents({Key? key}) : super(key: key);

//   @override
//   State<ProfileStudents> createState() => _ProfileStudentsState();
// }

// class _ProfileStudentsState extends State<ProfileStudents> {
//   @override
//   Widget build(BuildContext context)  {

//     final studentServices = Provider.of<StudentServices>(context);
//          final student = studentServices.student;
//     // late Student student = studentServices.getStudentForID(token);

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xff1C1D21),
//         title: const Text(
//           'Perfil',
//           style: TextStyle(fontSize: 20, color: Colors.white70),
//         ),
//       ),
//       body: SafeArea(
//         child: Container(
//           color: const Color(0xff1C1D21),
//           width: double.infinity,
//           height: double.infinity,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   //  Image.asset('assets/images/user.png'),
//                   const SizedBox(height: 20),

//                   Center(
//                     child: Column(children: [
//                       const Foto(),
//                       const SizedBox(height: 20),
//                       _text(
//                           text:
//                               '${student.name + "  " + student.lastName + "  " + student.secondName}'),
//                       _text(text: '${student.tuition}'),
//                     ]),
//                   ),

//                   // _text(text: 'Datos Personales'),

//                   const SizedBox(height: 10),
//                   const Text(
//                     'DATOS PERSONALES',
//                     style: TextStyle(fontSize: 17, color: Colors.white54),
//                   ),
//                   const SizedBox(height: 20),

//                   DataStudent(
//                     student: student,
//                   ),
//                   const SizedBox(height: 10),
//                   _text(text: "DATO DEL TUTOR"),

//                   const SizedBox(height: 20),

//                   DataStudentTutor(
//                     student: student,
//                   ),
//                   const SizedBox(height: 20),

//                   _text(text: 'DATOS ESCOLARES'),

//                   const SizedBox(height: 10),
//                   DataStudentSchool(student:  student,), // photo poto para el perfil
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//           onPressed: () {}, label: const Text('Editar Datos')),
//     );
//   }
// }

// class DataStudentTutor extends StatelessWidget {
//   final Student student;

//   const DataStudentTutor({Key? key, required this.student}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // color:const Color(0xff242529),
//       width: double.infinity,
//       // height: 300,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5),
//         color: const Color(0xff242529),
//         // ignore: prefer_const_literals_to_create_immutables
//         boxShadow: [
//           const BoxShadow(
//             // color: Colors.black,
//             color: Colors.black54,
//             offset: Offset(5, 5),
//             blurRadius: 10,
//             spreadRadius: 5,
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           const SizedBox(height: 10),
//           _text(text: 'Edad:  ${student.studentTutor!.nameTutor + student.studentTutor!.lastNameTutor + student.studentTutor!.secondNameTutor}'),
//           _text(text: 'Numero de  Telefono: ${student.studentTutor!.numberPhoneTutor.toString()}'),
//           _text(text: "Parentesco: ${student.studentTutor!.kinship}"),
//         ]),
//       ),
//     );
//   }
// }

// class DataStudent extends StatefulWidget {
//   final Student student;

//   const DataStudent({Key? key, required this.student}) : super(key: key);

//   @override
//   State<DataStudent> createState() => _DataStudentState();
// }

// class _DataStudentState extends State<DataStudent> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // color:const Color(0xff242529),
//       width: double.infinity,
//       // height: 300,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: const Color(0xff242529),
//         // ignore: prefer_const_literals_to_create_immutables
//         boxShadow: [
//           const BoxShadow(
//             // color: Colors.black,
//             color: Colors.black54,
//             offset: Offset(5, 5),
//             blurRadius: 10,
//             spreadRadius: 5,
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           SizedBox(height: 10),
//           _text(text: 'Edad:  ${widget.student.age}'),
//           _text(text: 'Sexo: ${widget.student.gender}'),
//           _text(
//               text: "Fecha de nacimiento: ${widget.student.dateOfBirth}"
//                   .substring(0, 31)),
//           _text(text: "Tipo de sangre: ${widget.student.bloodGrade}"),
//           _text(text: 'Telefono: ${widget.student.numberPhone}'),
//           _text(text: 'Numero de control: ${widget.student.tuition}'),
//           _text(text: 'Dirreccion : ${widget.student.town}'),
//         ]),
//       ),
//     );
//   }
// }

// class DataStudentSchool extends StatelessWidget {


//    // receibe how paramer class student 
//    final Student student;

//   const DataStudentSchool({Key? key, required this.student}) : super(key: key);
   

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // color:const Color(0xff242529),
//       width: double.infinity,
//       // height: 300,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5),
//         color: const Color(0xff242529),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children:  [
//               SizedBox(height: 10),
//               _text(text: 'Semestre'),
//               _text(text: 'Grupo'),
//               _text(text: 'Siclo escolar ${student.generation}'),
//             ]),
//       ),
//     );
//   }
// }

// class _text extends StatelessWidget {
//   final String text;

//   const _text({Key? key, required this.text}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       style: const TextStyle(
//         fontSize: 16,
//         color: Colors.white54,
//         // color: Colors.white12
//       ),
//     );
//   }
// }

// class Foto extends StatefulWidget {
//   const Foto({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<Foto> createState() => _FotoState();
// }

// // estenxion para las animacioes
// // extends TickerProviderStateMixin
// class _FotoState extends State<Foto> with TickerProviderStateMixin {
//   // controlador de la animacion
//   late AnimationController _controller;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     //  agregar valores por defecto d la aminacio
//     _controller =
//         AnimationController(duration: const Duration(seconds: 1), vsync: this);
//     _controller.forward();
//     // _controller.reset();
//   }

//   // con esto terminamos la  destruimos laanimacio
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // return ScaleImage(controller: _controller);
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, widget) => Transform.scale(
//         scale: _controller.value * 1,
//         child: widget,
//       ),
//       child: Container(
//         width: 105,
//         height: 105,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(50),
//           color: Colors.red,
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(50),
//           child: Image.network(
//             "https://imagesvc.meredithcorp.io/v3/mm/image?url=https:%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2020%2F02%2Fkatherine-johnson.jpg",
//             fit: BoxFit.fill,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ScaleImage extends AnimatedWidget {
//   const ScaleImage({
//     Key? key,
//     required AnimationController controller,
//   }) : super(key: key, listenable: controller);

//   Animation<double> get _progress => listenable as Animation<double>;

//   @override
//   Widget build(BuildContext context) {
//     // return Transform.rotate(
//     return Transform.scale(
//       filterQuality: FilterQuality.medium,
//       transformHitTests: true,
//       // angle: _progress.value * 2.0 * math.pi,
//       alignment: Alignment.center,
//       scale: 1,
//       origin: const Offset(0, 0),
//       // scaleX: 3,
//       // scaleY: 3,
//       child: Container(
//         width: 90,
//         height: 90,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5),
//           color: Colors.red,
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(5),
//           child: Image.network(
//             "https://imagesvc.meredithcorp.io/v3/mm/image?url=https:%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2020%2F02%2Fkatherine-johnson.jpg",
//             fit: BoxFit.fill,
//           ),
//         ),
//       ),
//     );
//   }
// }
