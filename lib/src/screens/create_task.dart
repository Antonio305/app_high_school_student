import 'dart:io';

// import 'package:achievement_view/achievement_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prepa_estudiantes/services/file_services.dart';

import '../../services/student_services.dart';
import '../../services/sumbmit_task_services.dart';
import '../model/task.dart';
// import 'package:achievement_view/achievement_view.dart';

// para agregar las tareas
import 'package:file_picker/file_picker.dart';

class ScreenCreateTask extends StatefulWidget {
  @override
  _ScreenCreateTaskState createState() => _ScreenCreateTaskState();
}

class _ScreenCreateTaskState extends State<ScreenCreateTask>
    with SingleTickerProviderStateMixin {
// funcion para abrir el codumento

  void filePicker() {}

  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller!);
    _controller!.forward();
  }

  File? file;
  String? nameFile;
  // FilePickerResult? result;

  @override
  Widget build(BuildContext context) {
    final Tasks task = ModalRoute.of(context)?.settings.arguments as Tasks;

    String? filePath;

    final student = Provider.of<StudentServices>(context, listen: false);

    final sendTask = Provider.of<SendTaskServices>(context);

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff1C1D21),
      appBar: AppBar(
        centerTitle: true,
        title: Text(task.subject.name),
        backgroundColor: const Color(0xff1C1D21),
      ),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _animation!,
          builder: (context, child) {
            return Opacity(
              opacity: _animation!.value,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: const Color(0xff1C1D21),

                // color: Colors.black54,En
                // color: const Color(0xff25282F),

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * 0.03),
                          // Center(
                          //   child: Text(task.subject.name,
                          //       style: const TextStyle(
                          //           color: Colors.white60, fontSize: 22)),
                          // ),
                          SizedBox(height: size.height * 0.02),
                          Center(
                            child: Text(task.nameTask,
                                style: const TextStyle(
                                    color: Colors.white60, fontSize: 20)),
                          ),
                          SizedBox(height: size.height * 0.07),
                          TextFormField(
                            style: const TextStyle(color: Colors.white60),
                            decoration: InputDecoration(
                                fillColor: Colors.white60,
                                hoverColor: Colors.white60,
                                focusColor: Colors.black87,
                                border: OutlineInputBorder(
                                  gapPadding: 0.2,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                // hintText: 'Hint text',
                                helperText: 'EL COMENTARIO NO ES OBLIGATORIO',
                                labelText: 'COMENTARIO'),
                            maxLines: 5,
                          ),
                          SizedBox(height: size.height * 0.03),
                          Card(
                            color: const Color(0xff25282F),
                            child: SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 30, horizontal: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    nameFile == null
                                        ? const Text(
                                            'NO HAY ARCHIVOS SELECCIONADOS')
                                        : Text(
                                            "$nameFile",
                                            style: const TextStyle(
                                                color: Colors.white60,
                                                fontSize: 14),
                                          ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    ElevatedButton(
                                      // color: Colors.black87,

                                      onPressed: () async {
                                        // intancia de la clase para abreri los archivos
                                        // PickerFiles resultPicker =
                                        //       PickerFiles()       ;
                                        // final  result =
                                        //       await resultPicker.pickerFile();
                                        FilePickerResult? result =
                                            await FilePicker.platform
                                                .pickFiles();
                                        if (result != null) {
                                          // File file =
                                          setState(() {
                                            // file = File(
                                            //     result.files.single.path!);
                                            file =
                                                File(result.files.single.path!);
                                          });
                                          nameFile = result.files.single.name;
                                          print(file!.path);
                                        } else {
                                          // User canceled the picker
                                          print('USER CANCELED THE PICKER');
                                        }
                                      },
                                      child: const Text(
                                        ' AGREGAR ARCHIVO ',
                                        style: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.09),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: sendTask.status == true
                                ? const CircularProgressIndicator.adaptive()
                                : MaterialButton(
                                    color: Colors.blue.withOpacity(0.7),
                                    onPressed: () async {
                                      final fileServices =
                                          Provider.of<FilesServices>(context,
                                              listen: false);

                                      // await sendTask.sendTask(
                                      //     student.student.uid!,
                                      //     task.id,
                                      //     'cahles');

                                      // ahy queregresar en la vida anterios
                                      // Navigator.pop(context);
                                      // taskReceived

                                      if (file == null) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Error"),
                                              content: const Text(
                                                  "No se ha seleccionado un archivo."),
                                              actions: [
                                                ElevatedButton(
                                                  child: const Text("OK"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                        // await sendTask.sendTask(
                                        //     student.student.uid!,
                                        //     task.id,
                                        //     'cahles');

                                        // Navigator.pushNamed(
                                        //     context, 'create_task');

                                        // print('No hay archivos seleccionados');
                                        return null;
                                      } else {
                                        // verificamos i no ehemos hechio el registro de los datos
                                        final Map<String, dynamic> respBody =
                                            await sendTask.getByStudentTask(
                                                student.student.uid!, task.id);

                                        if (respBody.containsKey('msg')) {
                                          await sendTask.sendTask(
                                              student.student.uid!,
                                              task.id,
                                              'cahles');

                                          await fileServices.uploadFiles(
                                              file, task.id, 'taskReceived');

                                          // AchievementView(
                                          //   context,
                                          //   color: Colors.orange,
                                          //   isCircle: true,
                                          //   title: "TAREA ENVIADO",
                                          //   subTitle: "FELICIDADES   " +
                                          //       student.student.name,
                                          //   icon: const Icon(Icons.star,
                                          //       color: Color.fromARGB(
                                          //           255, 126, 120, 209)),
                                          //   typeAnimationContent:
                                          //       AnimationTypeAchievement
                                          //           .fadeSlideToUp,
                                          //   borderRadius:
                                          //       BorderRadius.circular(10),
                                          // ).show();

                                          //   showDialog(
                                          //     context: context,
                                          //     builder: (BuildContext context) {
                                          //       return AlertDialog(
                                          //         title:
                                          //             const Text("FELICIDADES"),
                                          //         content: Text(respBody['msg']),
                                          //         actions: [
                                          //           ElevatedButton(
                                          //             child:
                                          //                 const Text("ACEPTAR"),
                                          //             onPressed: () {
                                          //               Navigator.of(context)
                                          //                   .pop();
                                          //             },
                                          //           ),
                                          //         ],
                                          //       );
                                          //     },
                                          //   );
                                        } else {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title:
                                                      const Text("FELICIDADES"),
                                                  content: const Text("YA HABIAS HECHO LA ENTREGA"),
                                                  actions: [
                                                    ElevatedButton(
                                                      child:
                                                          const Text("ACEPTAR"),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );

                                          // await sendTask.sendTask(
                                          //     student.student.uid!,
                                          //     task.id,
                                          //     'cahles');

                                          // await fileServices.uploadFiles(
                                          //     file, task.id, 'taskReceived');

                                          // AchievementView(
                                          //   context,
                                          //   color: Colors.orange,
                                          //   isCircle: true,
                                          //   title: "TAREA ENVIADO",
                                          //   subTitle: "FELICIDADES   " +
                                          //       student.student.name,
                                          //   icon: const Icon(Icons.star,
                                          //       color: Color.fromARGB(
                                          //           255, 126, 120, 209)),
                                          //   typeAnimationContent:
                                          //       AnimationTypeAchievement
                                          //           .fadeSlideToUp,
                                          //   borderRadius:
                                          //       BorderRadius.circular(10),
                                          // ).show();
                                        }
                                      }
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          top: 8,
                                          bottom: 8,
                                          right: 45,
                                          left: 45),
                                      child: Text('ENVIAR  TAREA'),
                                    ),
                                  ),
                          ),
                          SizedBox(height: size.height * 0.04),
                        ]),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
