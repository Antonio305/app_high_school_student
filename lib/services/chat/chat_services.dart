import 'package:flutter/cupertino.dart';
import 'package:prepa_estudiantes/src/model/chat/messages.dart';
import 'package:prepa_estudiantes/src/model/host.dart';
import 'package:prepa_estudiantes/src/model/subjects.dart';

// libreriapra peticiones http
import 'package:http/http.dart' as http;

// par convertir json

import '../login_services.dart';
import 'dart:convert';

class ChatServices with ChangeNotifier {
// usuari para el que se le envia el menaje

  Teachers? userPara;

  // metodo  para obtener la lista de los mensajes

  Future<List<Message>> getMessage(String de) async {
    // get token
    String? token = await LoginServices.getToken();

    // urol
    final url = ConectionHost.myUrl('/api/messages/$de', {});
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-token': token!
    };

    final resp = await http.get(url, headers: headers);
    final respBody = json.decode(resp.body);

    final messagesResp = messagesFromJson(resp.body);

    print(respBody);
    return messagesResp.messages;
  }
}
