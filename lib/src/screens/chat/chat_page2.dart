

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage2 extends StatefulWidget {
  const ChatPage2({Key? key}) : super(key: key);

  @override
  State<ChatPage2> createState() => _ChatPage2State();
}

class _ChatPage2State extends State<ChatPage2> {
    // para sabert si esta escribiendo
  bool writing = false;

  final TextEditingController _textController = TextEditingController();

  // controlador para el focus nods
  final _focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              appBar: AppBar(
          centerTitle: true,
          title: Text('fkljsdafklsdjfklasdjfdskl'),
          elevation: 1,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.exit_to_app),
          ),
          // esto cambiar dependido si tnemos coneccion o no
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              // falta co cofigurcion si tenemos coneccion o no
              child: Icon(Icons.check_circle, color: Colors.blue[500]),
              // Icon(Icons.offline_bolt, color: Colors.red),
            )
          ],
        ),
        body: Container(
          child: Column(children: [
            Flexible(
              child: ListView.builder(
                reverse: true,
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  // return _messages[index];
                  return  Text('fdsikfjsdkfldsj');
                },
              ),
            ),


                        Divider(
              height: 1,
            ),



             Container(
              // color: Colors.red,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    // caja de texto
                    Flexible(
                      child: TextField(
                        focusNode: _focusNode,
                        decoration: const InputDecoration.collapsed(
                            hintText: 'Enviar mensjae'),
                        controller: _textController,
                        // solo agrego la referencia
                        // onSubmitted: (){},
                        // TODO: hay que saber cuando esta escribiendo, cuando hay un valor
                        onChanged: (value) {
                          setState(() {
                            if (value.trim().length > 1) {
                              writing = true;
                            } else {
                              writing = false;
                            }
                          });
                        },
                      ),
                    ),
                    // button

                    Container(
                      child: Platform.isIOS
                          ? CupertinoButton(
                              child: const Text('Send'),
                              onPressed:(){}
                            )
                          : IconButton(
                              onPressed:(){},
                             

                              icon: const Icon(Icons.send),
                              // DELETE ANIMATIN OCOLOR
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                    ),
                    // IconButton(onPressed: (){}, icon: )
                  ]),
                ),
              ),
            )
          ]),),
    );
  }
}