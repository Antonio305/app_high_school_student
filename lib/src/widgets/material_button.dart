


import 'package:flutter/material.dart';

class ButtonOptions extends StatelessWidget {
     final IconData icon;
     final Function? onPressed;
     final String text;
    //  final Color? backgroundColor;

  const ButtonOptions({Key? key,this.onPressed,required this.text, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const     style1 =  TextStyle(fontSize: 14, color: Colors.white70);
    // const     style1 =  TextStyle(fontSize: 18, color: Colors.white70);

    return Container(
      decoration: BoxDecoration(
      ),
      child: ListTile(
        // focusColor: Colors.white38,
        selectedColor: Colors.white,
      onTap:(){
        
          onPressed!();
        } ,
        leading: Icon(icon, color: Colors.white30),
        title: Text(text, style:  style1,),
        // color: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );

  }
}