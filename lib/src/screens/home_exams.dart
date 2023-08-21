

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:prepa_estudiantes/src/widgets/card_examns_resp.dart';


class HomeExams extends StatefulWidget {
 const  HomeExams({Key? key}) : super(key: key);

  @override
  State<HomeExams> createState() => _HomeExamsState();
}

class _HomeExamsState extends State<HomeExams> {
  
  @override
  Widget build(BuildContext context) {
    
     final size = MediaQuery.of(context).size;
      // color: const Color(0xff2D3134),
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        
         AwesomeDialog(context: context,
        dialogBackgroundColor: const Color(0xff1C1D21),
        //  barrierColor: Colors.amber,
        closeIcon: const Icon(Icons.ac_unit),
         dialogType: DialogType.SUCCES,
         headerAnimationLoop: false,
         animType: AnimType.TOPSLIDE,
         title: 'Cuidado',
         titleTextStyle:const TextStyle(color: Colors.white54),
         desc: 'Verifica tus respustas',
         descTextStyle:const  TextStyle( color: Colors.white54 ),
         btnCancelText: 'Cancelar',
         btnCancelOnPress: (){},
          btnOkText: 'Enviar Respuesta',
         btnOkOnPress: (){},
        
        ).show();

      }, label: const Text(' Enviar Respuesta')),
      appBar: AppBar(
      title: const Text('Examen de mate.'),
      backgroundColor: const Color(0xff1C1D21),
      ),
      
      body: Container(
        color: const Color(0xff1C1D21),
         child: ListView(
           children:List.generate(10, (index) => const CardExamsResp()),
         )
      ),
      );
           

  }
}

