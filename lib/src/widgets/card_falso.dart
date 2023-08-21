import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prepa_estudiantes/services/login_services.dart';
import 'package:prepa_estudiantes/services/student_services.dart';
import 'package:prepa_estudiantes/services/task_services.dart';
import 'package:prepa_estudiantes/src/model/student.dart';

import '../model/horarios.dart';

class Data extends StatelessWidget {
  final GroupHorarios horarios;

  const Data({Key? key, required this.horarios}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // Card principal
      child: GestureDetector(
        onTap: () async {
          // Navigator.pushNamed(context, 'details_class');
        },
        child: Container(
          width: 300,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xff242529),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 5, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xff2D3134),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          'https://1.bp.blogspot.com/-hKWna8tABtw/YKfuOXv0_8I/AAAAAAAAByI/n3F1U6j3YB0v53gjhIlEqoZeTlG_oD_VgCLcBGAsYHQ/s400/giphy.gif',
                          fit: BoxFit.fill,
                        ),
                      ),
                    )),

                // testo de la materia y el horario
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Text(
                        horarios.name,
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                      ),
                      Row(
                        children: const [
                          Icon(Icons.watch_later_outlined,
                              color: Colors.white24),
                          SizedBox(
                            width: 15,
                          ),
                          Text('8:00 - 8:45',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.white24)),
                        ],
                      ),
                    ],
                  ),
                ),

                // contnerod de la llamda.
                const SizedBox(
                  width: 30,
                ),
                // const SizedBox.expand(),
                // MaterialButton(
                //   onPressed: () => Navigator.pushNamed(context, 'entry_class'),
                //   child: RotatedBox(
                //     quarterTurns: 1,
                //     child: Container(
                //       width: double.infinity,
                //       height: 40,
                //       decoration: BoxDecoration(
                //         color: const Color(0xff4CCFFF).withOpacity(0.6),
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       child: Padding(
                //         padding: const EdgeInsets.all(5.0),
                //         child: Row(
                //           children: const [
                //             Text(
                //               'Unirme',
                //               style:
                //                   TextStyle(fontSize: 15, color: Colors.white),
                //             ),
                //             SizedBox(
                //               width: 5,
                //             ),
                //             Icon(
                //               Icons.missed_video_call_sharp,
                //               color: Colors.white,
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
