import 'package:flutter/material.dart';

class CardChat extends StatelessWidget {
  final String name;
  final String materia;
  final String image;

  const CardChat(
      {Key? key,
      required this.name,
      required this.materia,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xff242529),
        ),
        width: double.infinity,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Row(
            children: [
              Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xff2D3134),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(image, width: 40, height: 40))),
              const SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      name,
                      style:
                          const TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    materia,
                    style: const TextStyle(fontSize: 15, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
