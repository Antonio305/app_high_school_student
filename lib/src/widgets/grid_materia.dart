import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Materias extends StatelessWidget {
  const Materias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                  //  color: Colors.white,
                   color:const Color(0xff242529),
                boxShadow:  [
                  BoxShadow(
                     color: Colors.white.withOpacity(0.3),
                    offset: const Offset(0,2),
                    blurRadius: 1, // efecto de la sombre en la parte inferior.
                    spreadRadius: 0.5,
                    blurStyle: BlurStyle.normal,
                  )
                ],
              ),

              height: 30,
           
              child:const Padding(
                padding:  EdgeInsets.all(8.0),
                child:  Center(
                  child: Text('MATEMATICAS'),
                ),
              ),
            ),
          );
        });
  }
}
