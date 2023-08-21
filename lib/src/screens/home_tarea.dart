import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prepa_estudiantes/services/file_services.dart';

import '../../services/student_services.dart';
import '../../services/sumbmit_task_services.dart';
import '../model/task.dart';
import '../widgets/screen_download.dart';

class HomeTarea extends StatefulWidget {
  const HomeTarea({Key? key}) : super(key: key);

  @override
  State<HomeTarea> createState() => _HomeTareaState();
}

class _HomeTareaState extends State<HomeTarea>
    with SingleTickerProviderStateMixin {
      
// controlador para la animacion del tecto
  late AnimationController _controller;
  late Animation<double> _animation;

  // inicializar el controlador
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // duracion  de la animation
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000))
      ..forward();

    // ..forward();
    // ..repeat(reverse: false);

    // animacion
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
  }

  // terminamos la  animacio del text
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  double porcentDownload = 0.0;
  String? downloadMessage = 'INITIZALIZED .......';
  bool isDownloading = false;

  String filename = 'ressssss.png';
  String url = 'https://i.ytimg.com/vi/Mtk8jiR-MF0/maxresdefault.jpg';
  // String url = 'http://elopez.fime.uanl.mx/@materias/800/Prog.%20basica.pdf';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // con vesto obtenemos el paramtro que recivimos del ruta
    final Tasks task = ModalRoute.of(context)?.settings.arguments as Tasks;

    final fileServices = Provider.of<FilesServices>(context);

    final student = Provider.of<StudentServices>(context, listen: false);

    final sendTask = Provider.of<SendTaskServices>(context);

    return Scaffold(
      backgroundColor: const Color(0xff1C1D21),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('MI TAREA'),
        backgroundColor: const Color(0xff1C1D21),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
      //  sendTask.status == true
      //     ? const CircularProgressIndicator()
      //     :
           FloatingActionButton.extended(
              onPressed: () async {
                // final Map<String, dynamic> respBody = await sendTask
                //     .getByStudentTask(student.student.uid!, task.id);

                // if (respBody.containsKey('msg')) {
                //   showDialog(
                //     context: context,
                //     builder: (BuildContext context) {
                //       return AlertDialog(                               
                //         title: const Text("FELICIDADES"),
                //         content: Text(respBody['msg']),
                //         actions: [
                //           ElevatedButton(
                //             child: const Text("ACEPTAR"),
                //             onPressed: () {
                //               Navigator.of(context).pop();
                //             },
                //           ),
                //         ],
                //       );
                //     },
                //   );
                //   return null;
                // } 
                
                  Navigator.pushNamed(context, 'create_task', arguments: task);
                
              },
              label: Text('ENTREGAR TAREA')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.04),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF05223A),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            task.subject.name,
                            style: TextStyle(
                                // fontFamily: 'sans-serif'
                                // fontFamily: 'Courier',
                                fontFamily: 'Roboto',
                                color: Colors.white60,
                                fontSize: _animation.value * 40),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Text(task.subject.name,
                //     style:
                //         const TextStyle(color: Colors.white60, fontSize: 22)),
                SizedBox(height: size.height * 0.03),
                const Text("Nombre de la tarea:",
                    style: TextStyle(color: Colors.white54)),

                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(task.nameTask,
                      style:
                          const TextStyle(color: Colors.white38, fontSize: 18)),
                ),
                SizedBox(height: size.height * 0.1),
                const Text('Descripcion : ',
                    style: const TextStyle(color: Colors.white38)),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(task.description,
                      style:
                          const TextStyle(color: Colors.white38, fontSize: 18)),
                ),
                SizedBox(height: size.height * 0.07),
                // await    fileServices.downloadFiles(),

                ScreenDownload(nameFile: filename, urls: url),

                SizedBox(height: size.height * 0.02),

                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'CATEDRATICO:',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        task.userTeacher.name +
                            " " +
                            task.userTeacher.lastName +
                            " " +
                            task.userTeacher.secondName,
                        style: const TextStyle(
                            color: Colors.white60, fontSize: 15),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),

                // // SizedBox(height: size.height * 0.02),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: MaterialButton(
                //     // color: Colors.white.withOpacity(0.7)
                //     color: Colors.blueAccent,
                //     onPressed: () {
                //       Navigator.pushNamed(context, 'create_task',
                //           arguments: task);
                //     },
                //     child: const Padding(
                //       padding: EdgeInsets.only(
                //           top: 8, bottom: 8, right: 45, left: 45),
                //       child: Text('ENTREGAR  TAREA'),
                //     ),
                //   ),
                // ),
                SizedBox(height: size.height * 0.1),
              ]),
        ),
      ),
    );
  }
}
