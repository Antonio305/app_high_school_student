import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  List<String> links = [
    'https://www.mundogatos.com/Uploads/mundogatos.com/ImagenesGrandes/fotos-de-gatitos-7.jpg',
    'https://i.pinimg.com/originals/f0/50/45/f05045dac9cb83f7665e8634581f5151.jpg',
    'https://i.pinimg.com/originals/f0/50/45/f05045dac9cb83f7665e8634581f5151.jpg',
    'https://i.pinimg.com/originals/f0/50/45/f05045dac9cb83f7665e8634581f5151.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, 'show_publication',
              //     arguments: publication[index]);
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff242529),
                  borderRadius: BorderRadius.circular(15),
                ),

                width: Platform.isAndroid || Platform.isIOS
                    ? size.width * 0.95
                    : 300,
                // height: 200,
                // color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                          radius: 20, child: Icon(Icons.person, size: 30)),
                      const SizedBox(width: 5),
                      SizedBox(
                        width: Platform.isAndroid || Platform.isIOS
                            ? size.width * 0.76
                            : 220,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text('ING. JAMIE HERNANDEX YONG',
                                style: TextStyle(color: Colors.white70)),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                                'Aniversio de la preparatoria'
                                // publication[index].title
                                ,
                                style: TextStyle(color: Colors.white54)),
                            SizedBox(
                              // width: 220,
                              width: Platform.isAndroid || Platform.isIOS
                                  ? size.width * 0.7
                                  : 220,

                              height: 230,
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    links.first,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              // ListView(
                              //   scrollDirection: Axis.vertical,
                              //   children: List.generate(links.length,
                              //       (index) {
                              //     return Padding(
                              //       padding: const EdgeInsets.all(3.0),
                              //       child: Image.network(links[index]),
                              //     );
                              //   }),
                              // ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );

          // return Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Container(
          //     width: 300,
          //     //  height: 80,
          //     decoration: BoxDecoration(
          //       //  color: Colors.white,
          //       color: const Color(0xff25282F),
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: SizedBox(
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             const Text('Aniversio de la preparatoria', style: TextStyle(fontSize: 18, color: Colors.white70),),
          //             const SizedBox(
          //               height: 10,
          //             ),
          //             ClipRRect(
          //                 borderRadius: BorderRadius.circular(10),
          //                 child: Image.network(
          //                   'https://media.blogto.com/articles/b2e3-20141224_weekendeventstoronto.jpg?w=1200&cmd=resize_then_crop&height=630&quality=70',
          //                   fit: BoxFit.fill,
          //                   width: double.infinity,
          //                   height: 100,
          //                 )),
          //                 const SizedBox(height:10,),
          //             const Text(
          //                 'Es una dee las fechas mas importante para  la preparatoria este evento se celebrea cada año', style: TextStyle(fontSize: 15, color: Colors.white70)),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // );
        });
  }
}
