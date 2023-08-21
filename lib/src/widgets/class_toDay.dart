import 'package:flutter/material.dart';

class ClassDay extends StatelessWidget {
  final String textDay;

  const ClassDay({Key? key,required this.textDay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          // Navigator.pushNamed(context, 'class_for_day');
        },
        child: Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(
           color: const Color(0xff4CCFFF).withOpacity(0.4),
             
            //  color: const Color(0xff4CCFFF).withOpacity(0.6),

            // gradient:const RadialGradient(
            //   colors:[
            //     // Colors.white,
            //      Color(0xFF1DA6FB),
            //   ],
            //   stops: [ 0.9],
            //   center: Alignment(0.06, 0.1),
            // ),
            borderRadius: BorderRadius.circular(10),
          ),
          child:  Center(
              child: Text(
            textDay,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          )),
        ),
      ),
    );
  }
}
