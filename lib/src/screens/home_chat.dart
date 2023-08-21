import 'package:flutter/material.dart';

class HomeChat extends StatelessWidget {
  const HomeChat({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Img Jaime'),
        backgroundColor: const Color(0xff1C1D21),
      ),
         body: Container(
                  width: double.infinity,
                  height: double.infinity,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(0),
               color:const Color(0xff1C1D21),
             ), 
           child: SafeArea(
              child: Center(
                child:MaterialButton(onPressed: (){},
                   child: const Text('Iniciar chat', style: TextStyle( fontSize: 18, color : Colors.white ),  ),
                ),
              ),
           ),
         ),
    );
  }
}