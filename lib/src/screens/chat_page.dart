import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prepa_estudiantes/services/chat/chat_services.dart';
import 'package:prepa_estudiantes/services/chat/socket_servives.dart';
import 'package:prepa_estudiantes/services/student_services.dart';
import 'package:prepa_estudiantes/src/screens/chat/chat_message.dart';

import '../model/chat/messages.dart';

class ChatPages extends StatefulWidget {
  const ChatPages({Key? key}) : super(key: key);

  @override
  State<ChatPages> createState() => _ChatPagesState();
}

class _ChatPagesState extends State<ChatPages> with TickerProviderStateMixin {
  // para sabert si esta escribiendo
  bool writing = false;

  final TextEditingController _textController = TextEditingController();

  // controlador para el focus nods
  final _focusNode = new FocusNode();

  // creo  una lista de chat Message
  List<ChatMessage> _messages = [];

  // solo se declara ya se inicializa en el init State
  ChatServices? chatService;
  // Teachers? chatService;

  // socker
  late SocketService socketService;
// de quie se le envia el mensale

// TODO PARA LISTA DE USUARIOS
//todo: control escolar no puede
  // UserServices? userService;
  // hace la instnacia del token
  // LoginServices? authService;

  StudentServices? authService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // aca no podemos redibujar nada, solo si estamos en un callback
    chatService = Provider.of<ChatServices>(context, listen: false);

    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<StudentServices>(context, listen: false);

    // PARA ESCUHAR EL MENAJE DEL EVENTO mensaje-personal

    socketService.socket.on("mensaje-personal", _escucharMensaje);
    socketService.socket
        .on('mensaje-personal', (data) => print('tengo mensaje de : ${data}'));

    // para cargars lo mensajes
    getMessages(chatService!.userPara!.id);
    maxCaracter();
  }

  final int _maxLength = 400;

  // para escuchar cuatas caracteres se van escribiendo
  void maxCaracter() {
    _textController.addListener(() {
      if (_textController.text.length > _maxLength) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Alerta'),
            content:
                Text('Has superado el número máximo de caracteres permitidos.'),
          ),
        );
      }
    });
  }

  // craer un function
  void _escucharMensaje(dynamic payload) {
    print('tengo mensaje de : ${payload}');
    ChatMessage message = ChatMessage(
      text: payload['message'],
      uid: payload['de'],
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 800)),
    );

    // Actualizacion de la lista
    setState(() {
      _messages.insert(0, message);
    });

    // faltaba la animacion jaja
    message.animationController.forward();
  }

  // para cargar lasi imagenes
  void getMessages(String usuarioID) async {
    List<Message> chats = await chatService!.getMessage(usuarioID);

    final history = chats.map((e) => ChatMessage(
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 0))
          ..forward(),
        text: e.message,
        uid: e.de));

    // agregar los mesajes en la lista
    setState(() {
      _messages.insertAll(0, history);
    });
  }

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff1C1D21),
          centerTitle: true,
          title: Text(chatService!.userPara!.name,
              style: const TextStyle(fontSize: 16)),
          elevation: 1,
          actions: [
            Container(
                margin: const EdgeInsets.only(right: 10),
                // falta co cofigurcion si tenemos coneccion o no
                child: socketService.serverStatus == ServerStatus.Online
                    ? const Icon(Icons.check_circle, color: Colors.black)
                    : const Icon(Icons.offline_bolt, color: Colors.white)

                // Icon(Icons.offline_bolt, color: Colors.red),
                )
          ],
        ),
        body: Container(
          // color: Colors.blue,
          color: const Color(0xff1C1D21),

          child: Column(children: [
            Flexible(
              child: Container(
                // color: Colors.green,
                child: ListView.builder(
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _messages[index];
                  },
                ),
              ),
            ),

            /// caja de texto
            // Divider(
            //   height: 0,
            // ),

            // es para la caja de texto

            Container(
              margin: const EdgeInsets.only(right: 8, left: 8, bottom: 5),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // caja de texto
                      Flexible(
                        child: Scrollbar(
                          controller: _scrollController,
                          // isAlwaysShown: true,
                          child: TextField(
                            scrollController: _scrollController,
                            // maxLength: 500,
                            maxLength: _maxLength,
                            maxLines:5 ,
                            minLines: 1,
                            // expands: true,
                            keyboardType: TextInputType.multiline,
                            focusNode: _focusNode,

                            // decoration: const InputDecoration.collapsed(
                            //     hintText: 'Enviar Mensajes'),
                            decoration: InputDecoration(
                               isDense: true,
                              counterText: '',
                              hintText: 'Enviar Mensajes',

                              // cuando el campo no se ha seleccionado
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 0.2, color: Colors.white),
                              ),

                              // cuando se esta usando
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 0.2, color: Colors.white38),
                              ),
                            ),
                            controller: _textController,
                            // solo agrego la referencia
                            onSubmitted: _haldleSubmit,
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
                      ),
                      // button

                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, left: 10),
                        child: Container(
                          child: Platform.isIOS
                              ? CupertinoButton(
                                  child: const Text('Send'),
                                  onPressed: writing
                                      ? () =>
                                          _haldleSubmit(_textController.text)
                                      : null,
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color: Colors.white10,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: IconButton(
                                    // color: const Color(0xff242529),

                                    onPressed: writing
                                        ? () => _haldleSubmit(
                                            _textController.text)
                                        : null,

                                    icon: const Icon(Icons.send),
                                    // DELETE ANIMATIN OCOLOR
                                    // splashColor: Colors.transparent,
                                    // highlightColor: Colors.transparent,
                                  ),
                                ),
                        ),
                      ),
                      // IconButton(onPressed: (){}, icon: )
                    ]),
              ),
            )
          ]),
        ));
  }

// para escuchar lo quehemos puesto
  _haldleSubmit(String text) async {
    if (text.trim().isEmpty) return;
    print(text);

    // este es para ios
    // solicitar el foco cuando se enviar los  mensjaes
    // en android n oes necesario
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      text: text,
      uid: authService!.student.uid!,
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 800)),
    );
    _messages.insert(0, newMessage);

    // una vex agergado en la lista inicar la animacin
    newMessage.animationController
        .forward(); // foward indica que es solo una vez
    setState(() {
      writing = false;
    });

// enviamos el mensaje
    // nombre del evento mensaje-personal
    socketService.emit('mensaje-personal', {
      'de': authService!.student.uid,
      'para': chatService!.userPara!.id,
      'message': text
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //TODO: OFF DEL SOCKET

    // LIMIAR LAS INSTANCIA DEL ARREGLO DE ChatMessage
    //  teminamos las animaciones que se han creado
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    socketService.socket.off('mensaje-personal');
    super.dispose();
  }
}
