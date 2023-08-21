import 'package:flutter/material.dart';

import '../model/task_received.dart';

import 'dart:io';

class CardTaskQualifield extends StatelessWidget {
  final List<TaskReceived> taskReceived;
  final int index;

  const CardTaskQualifield(
      {Key? key, required this.taskReceived, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // width: double.infinity,
        width: Platform.isMacOS || Platform.isWindows ? 400 : 330,

        // height: 255
        decoration: BoxDecoration(
          // color: Theme.of(context).brightness == Brightness.dark
          //     ? Colors.white38
          //     // : Colors.black12,
          // // Theme.of(context).brightness == Brightness.dark
          //  Colors.black12
          // ? const Color(0xff25282F)
          // : Colors.white30,

          color: const Color(0xff25282F),
          // color: Colors.red,

          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: SizedBox(
                  // width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        taskReceived[index].task!.nameTask,
                        // tasks.subject.name,
                        // 'Matematicas',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white70),
                      ),
              
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      // logugar para el texto jjajaaja
                      // Text(
                      //   taskReceived[index].task!.description,
                      //   // 'LA INVESTIGACION ESTA BASA EN LAS  ANOMALIAS DE LA GRAVEDAD',
                      //   style: const TextStyle(color: Colors.white70),
                      // ),
              
                      const SizedBox(
                        height: 10,
                      ),
              
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xff2D3134),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Calificacion : " +
                                taskReceived[index].rating.toString(),
                            // 'LA INVESTIGACION ESTA BASA EN LAS  ANOMALIAS DE LA GRAVEDAD',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Row(
                      //   children: [
                      //     Image.asset('asset/iconito.png'),
                      //     Container(
                      //       height: 32,
                      //       width: 32,
                      //       decoration: BoxDecoration(
                      //         borderRadius:
                      //             BorderRadius.circular(32),
                      //       ),
                      //       child: ClipRRect(
                      //           borderRadius:
                      //               BorderRadius.circular(50),
                      //           child: Image.network(
                      //             'http://www.ugr.es/~jmaroza/images/Ramanujan.jpg',
                      //             fit: BoxFit.fill,
                      //           )),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
              Container(
                  // color: Colors.red,
                  width: 80,
                  height: 120,
                  child: Image.asset('asset/taskqualified.png')),
            ],
          ),
        ),
      ),
    );
  }
}
