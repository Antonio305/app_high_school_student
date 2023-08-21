

import 'package:flutter/material.dart';

class Events extends StatelessWidget {
  const Events({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
           width: 300,
           height: 80,
           decoration: BoxDecoration(
             color: Colors.white,
             borderRadius:BorderRadius.circular(10),
             
           ),
           child: ClipRRect(
             borderRadius: BorderRadius.circular(10),
                          child: Image.network('https://media.blogto.com/articles/b2e3-20141224_weekendeventstoronto.jpg?w=1200&cmd=resize_then_crop&height=630&quality=70', fit: BoxFit.fill,)),
      ),
    );
  }
}