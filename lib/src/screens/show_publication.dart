import 'package:flutter/material.dart';

import '../model/publication.dart';

class ShowPublication extends StatelessWidget {
  const ShowPublication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // recebie publicaciont in nthe list

    Publication publication =
        ModalRoute.of(context)?.settings.arguments as Publication;

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xff1C1D21),
      appBar: AppBar(
        backgroundColor: const Color(0xff1C1D21),
//  scrolledUnderElevation: 20,
        // flexibleSpace: Container(color: Colors.red,),
        bottomOpacity: 0,
        title: const Text('Ver publicacion'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 5,
                child: SizedBox(
                  height: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://misanimales.com/wp-content/uploads/2021/06/foca-sale-agua-1024x768.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              // title
              Container(
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(10),
                    // color: const Color(0xff2D3134),
                    ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    publication.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.white70,
                        textBaseline: TextBaseline.alphabetic),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  publication.description!,
                  style: const TextStyle(fontSize: 16, color: Colors.white54),
                ),
              ),
              const SizedBox(
                height: 80,
              ),

              Align(
                  alignment: Alignment.bottomRight,
                  child: Text(publication.author!.name +
                      "  " +
                      publication.author!.lastName +
                      "  " +
                      publication.author!.secondName, style: const TextStyle(fontSize: 14, color: Colors.white30))),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
