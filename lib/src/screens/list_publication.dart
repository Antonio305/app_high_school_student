import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/publication_services.dart';
import '../model/publication.dart';
// import 'package:sistema_escolar_prepa/Services/file_services.dart';

class ScreenListPublication extends StatefulWidget {
  const ScreenListPublication({Key? key}) : super(key: key);

  @override
  State<ScreenListPublication> createState() => _ScreenListPublicationState();
}

class _ScreenListPublicationState extends State<ScreenListPublication> {
  List<Publication> publication = [];

  @override
  void initState() {
    // TODO: implement initState
    publication = [];
  }

  List<String> links = [
    'https://www.mundogatos.com/Uploads/mundogatos.com/ImagenesGrandes/fotos-de-gatitos-7.jpg',
    'https://i.pinimg.com/originals/f0/50/45/f05045dac9cb83f7665e8634581f5151.jpg',
    'https://i.pinimg.com/originals/f0/50/45/f05045dac9cb83f7665e8634581f5151.jpg',
    'https://i.pinimg.com/originals/f0/50/45/f05045dac9cb83f7665e8634581f5151.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    final publicationServices = Provider.of<PublicationServices>(context);
    //  publicationServices.
    publication = publicationServices.publication;
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color(0xff1C1D21),
        appBar: AppBar(
          title: const Text('Publicacion'),
          backgroundColor: const Color(0xff1C1D21),
        ),
        body: Padding(
          padding: Platform.isAndroid || Platform.isIOS
              ? const EdgeInsets.symmetric(horizontal: 0, vertical: 0)
              : const EdgeInsets.all(50.0),
          child: Container(
              child: publication.isEmpty
                  ? Center(child: const CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Wrap(
                        children: List.generate(publication.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              // Navigator.pushNamed(context, 'update_publication',
                              //     arguments: publication[index]);

                              Navigator.pushNamed(context, 'show_publication',
                                  arguments: publication[index]);
                            },
                            child: Container(
                              // margin: const EdgeInsets.only(bottom: 10),
                              // semanticContainer: true,
                              // borderOnForeground: true,
                              decoration: const BoxDecoration(
                                  // color: Color(0xff25282F),
                                  border: Border.symmetric(
                                      horizontal: BorderSide(
                                          color: Colors.white12, width: 0.5))),

                              // color: Colors.red,
                              child: SizedBox(
                                width: Platform.isAndroid || Platform.isIOS
                                    ? size.height
                                    : 270,
                                // height: 200,
                                // color: Colors.red,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CircleAvatar(
                                          radius: 20,
                                          child: Icon(Icons.person, size: 30)),
                                      const SizedBox(width: 7),
                                      SizedBox(
                                        width:
                                            Platform.isAndroid || Platform.isIOS
                                                ? size.width * 0.78
                                                : 220,
                                        child: Column(
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,

                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  publication[index]
                                                          .author!
                                                          .name +
                                                      " " +
                                                      publication[index]
                                                          .author!
                                                          .lastName
                                                  // +
                                                  // " " +
                                                  // publication[index]
                                                  //     .author!
                                                  // .secondName
                                                  ,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white70,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  '( ${publication[index].author!.rol} )',
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white54,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              publication[index].title,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white60),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            SizedBox(
                                              // width: 220,
                                              width: Platform.isAndroid ||
                                                      Platform.isIOS
                                                  ? size.width * 0.98
                                                  : 220,

                                              height: publication[index]
                                                          .description ==
                                                      null
                                                  ? 300
                                                  : 330,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                              height: 6,
                                            ),
                                            publication[index].description ==
                                                    null
                                                ? const SizedBox()
                                                : Text(
                                                    publication[index]
                                                        .description!,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white38),
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
                        }),
                      ),
                    )),
        ));
  }
}
