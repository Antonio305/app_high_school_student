

import 'package:flutter/material.dart';

class ChatGrupal extends StatelessWidget {
  const ChatGrupal({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(children: [
          const Text('CHAT VACIO'),
            MaterialButton(onPressed: (){},
            child: const Text('INICIAR CHAT'),
            )
        ],),
      ),
      
    );
  }
}