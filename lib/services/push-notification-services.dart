
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import  'package:prepa_estudiantes/firebase_options.dart';

class PushNotificationServices {
  // stream para estar escuchandod si hay una entreda de mensajes
// controlador
  static StreamController<String> _messageStreamController =
      StreamController.broadcast();
  static Stream<String> get streamMessage => _messageStreamController.stream;

  // cada funtion de de tipo estatito
  // para no hadcer la referencia de la clase

  // isntance in the Firebase
  static FirebaseMessaging messagig = FirebaseMessaging.instance;
  //save token
  static String? token;

  // create three funcion

// cuando la aplicacion esta en segundo plano
  static Future _backgroundHandler(RemoteMessage message) async {
    //  mostra el ID del mensaje
    print('backgroundMessage +  ${message.data}');
  }

// primer plano
  static Future _onMessageHandler(RemoteMessage message) async {
    //  mostra el ID del mensaje
    print('backgroundMessage +  ${message.data}');
  }

// Apliccion abierta

  static Future _onOpenMessageOpenApp(RemoteMessage message) async {
    //  mostra el ID del mensaje
    print('backgroundMessage +  ${message.data}');
  }

// funcion para inicializar FirebaseMessegig
  static Future initializeApp() async {
    await Firebase.initializeApp(
       options: DefaultFirebaseOptions.currentPlatform,
    );

    /// obtenennso el otken

    token = await FirebaseMessaging.instance.getToken();
    print(token);

    // agergar las  funciton en sus repsedctivas relacioens con ele estado de ala aplicacion
    // como parametro recivimoms un callback en la cual solo es una function
    FirebaseMessaging.onBackgroundMessage(
        _backgroundHandler); // apllicacion destruicdi

// segundo plano
    FirebaseMessaging.onMessage.listen(_onMessageHandler);

// CUANDO ESTA DENTRO DE LA APLCIACION
    FirebaseMessaging.onMessageOpenedApp.listen(_onOpenMessageOpenApp);
  }

  // funcion pata indicar de que un dia vamos a cerrar el Stream

  static closeStream() {
    _messageStreamController.close();
  }
}
