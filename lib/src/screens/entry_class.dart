


import 'package:flutter/material.dart';


class EntryClass extends StatelessWidget {
  const EntryClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xff1C1D21),
          title:const Text('Bienvenido ala clase',style: TextStyle(fontSize: 20, color: Colors.white70),),
        ),
        body: SafeArea(
          child:  Container(
            width: double.infinity,
              color: const Color(0xff1C1D21),
              child: Column(
                children:const [
                  Text('Hola  bievenidos ala clase'),
                ],
              )),
        ),
      );
    
  }
}