import 'package:flutter/material.dart';

class CardExamsResp extends StatefulWidget {
  const CardExamsResp({Key? key}) : super(key: key);

  @override
  State<CardExamsResp> createState() => _CardExamsRespState();
}

class _CardExamsRespState extends State<CardExamsResp> {
  // final String name;
    int? _groupValue = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // style text
    const style1 = TextStyle(fontSize: 18, color: Colors.white38);


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xff242529),
        ),
        width: double.infinity,
        // height: size.height * 0.250,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            const Text(
              '¿Reazalizar la siguiente suma de los 200+455+0?',
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            const SizedBox(
              height: 0.05,
            ),
            // Row( children: [
            //     Radio( value: 0, groupValue: groupValue, onChanged: (value){}),
            // Radio( value: 1, groupValue: groupValue, onChanged: (value){}),
            Row(
              children: [
                Row(
                  children: [
                    Radio( 
                        groupValue: _groupValue,
                        value: 0,
                        onChanged: ( dynamic t) {
                           setState(() {
                             _groupValue = t;
                          });
                        }),
                    const Text('655', style: style1),
                  ],
                ),
                Row(
                  children: [
                    Radio( 
                        groupValue: _groupValue,
                        value: 1,
                        onChanged: (dynamic t) {
                          setState(() {
                             _groupValue = t;
                          });
                        }),
                    const Text(
                      '0',
                      style: style1,
                    ),
                  ],
                )
              ],
            ),
            
            Row(
              children: [
                Row(
                  children: [
                    Radio( 
                        value: 2,
                        groupValue: _groupValue,
                        onChanged: (dynamic value) {
                           setState(() {
                             _groupValue = value;
                          });
                        }),
                    const Text('30', style: style1),
                  ],
                ),

                Row(
                  children: [
                    Radio( 
                        value: 3,
                        groupValue: _groupValue,
                        onChanged: (dynamic value) {
                           setState(() {
                             _groupValue = value;
                          });
                        }),
                    const Text('33343434', style: style1),
                  ],
                )
              
              
              ],
            )
          
           
          ]),
        ),
      ),
    );
  }
}
