import 'package:flutter/material.dart';

import '../widgets/class_day.dart';
import '../widgets/class_toDay.dart';

class ClassForDat extends StatelessWidget {
  const ClassForDat({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Martes'),
              backgroundColor: const Color(0xff1C1D21),
      ),
      body: SafeArea(
       child: Container(
          // color: const Color(0xff1C1D21),
            color: const Color(0xff1C1D21),
         child: ListView.builder(
           itemCount: 20,
           itemBuilder: (BuildContext context, int index) {
            return Container(
              width: 200,
              height: 200,
              color: Colors.red,
            );
            // TODO: HAY QUE CHECARLO TODAVIA
            //  return  const ClassToDay();
           },
         ),
       ),
      ),
    );
  }
}