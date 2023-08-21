import 'package:flutter/material.dart';

import '../model/horarios.dart';

class ClassToDay extends StatelessWidget {
  final List<GroupHorarios> horarios;
  final int index;

  const ClassToDay({Key? key, required this.horarios, required this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // Card principal
      child: GestureDetector(
        // onTap: () => Navigator.pushNamed(context, 'details_class'),
        onTap: () {
          // print(horarios[index].);
        },
        child: Container(
          width: 300,
          // height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xff242529),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 5, top: 10, bottom: 10),
            child: Column(
              children: [
                Row(
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
                              'https://img2.freepng.es/20181124/vy/kisspng-vector-graphics-physics-logo-image-drawing-studiants-fsica-jgm-charlasenfisica-twitter-5bf93da5411fd8.9532590215430609012668.jpg',
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
                          SizedBox(
                            width: 200,
                            child: Text(
                              horarios[index].name,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white70),
                            ),
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
                    //         // color: const Color(0xff4CCFFF).withOpacity(0.6),
                    //         color: const Color(0xff4CCFFF).withOpacity(0.4),

                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(5.0),
                    //         child: Row(
                    //           children: const [
                    //             // Text('Unirme', style:TextStyle(fontSize: 15, color: Colors.white),),

                    //             Text(
                    //               'Unirme',
                    //               style: TextStyle(
                    //                   fontSize: 15, color: Colors.white54),
                    //             ),
                    //             SizedBox(
                    //               width: 5,
                    //             ),
                    //             //  Icon(Icons.missed_video_call_sharp, color: Colors.white,),
                    //             Icon(
                    //               Icons.missed_video_call_sharp,
                    //               color: Colors.white54,
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Row(
                  children: const [
                    Icon(Icons.watch_later_outlined, color: Colors.white24),
                    SizedBox(
                      width: 15,
                    ),
                    Text('8:00 - 8:45',
                        style: TextStyle(fontSize: 15, color: Colors.white24)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
