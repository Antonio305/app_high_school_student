import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:prepa_estudiantes/services/secure_storage.dart';
import 'package:prepa_estudiantes/src/model/host.dart';

import '../src/model/login.dart';

late LoginUser userLogin;

bool isLoading = false;

class LoginServices extends ChangeNotifier {
  // aca vamos guardar el token

  final storage = SecureStorage.storage;

  final String baseUrl = ConectionHost.baseUrl;

  String? myToken;

  // final String baseUrl = "localhost:8080";
  // funtion para obtener los datos

  final headers = {'content-Type': 'application/json'};

  // metood para el login

  // Future<String?> loginUser(LoginUser login) async {
  Future<String?> loginUser(LoginUser login) async {
    // Future<String?> loginUser() async {
    //  isLoading = true;
    //  notifyListeners();

// cuando se ejecuta esto cambiamos el esto de la aplicacion

    final url = ConectionHost.myUrl('/api/userLogin/student', {});

    final headers = {'content-Type': 'application/json'};

    print(url);
    final resp = await http.post(url,
        headers: headers,
        body:
            // json.encode({"user": "DATOSGGGGGFDD555", "password": "1234567890"})
            //  json.encode(login.toJson())
            login.toJson());

    final Map<String, dynamic> decodeResp = json.decode(resp.body);
    
    print(decodeResp['token']);
    // final  decodeResp =  json.decode(resp.body);
    // print(decodeResp['msg']);
    print("datos del body $decodeResp");

    if (decodeResp.containsKey('token')) {
      // TODO: GUARDAR TOKEN EN UN LUGAR SEGURO
      // myToken = decodeResp['token'];
      await storage.write(key: 'token', value: decodeResp['token']);
      notifyListeners();

      return null; // no retornamos nada si pasa bien
    } else {
      // caso contrario mostramos el mensaje de error
      return decodeResp['msg'];
    }

// codigo 200 indica que todo esta biem
    //   if (resp.statusCode == 200) {
    //     print('Datos con exito');
    //     print(decodeResp);
    //   } else {
    //     print(decodeResp);
    //   }
    // // isLoading = false;
  }

// metod para elimitar lo que esta guardado del storage

  Future logout() async {
    await storage.delete(key: 'token');
    return;
    // esot no es necesario
  }

//esto nos va a retornar si existe el token
  Future<String> readToken() async {
    // esto puede puede ser nulo en la cual definimos un valor por defecto
    // como una valor vacio
    return await storage.read(key: 'token') ?? '';
  }

  Future<String?> myTokenID() async {
    // return  myToken!;

    String? myTokenn = await storage.read(key: 'token') ?? '';

    return myTokenn;
  }

  static Future<String?> getToken() async {
    const _storage = FlutterSecureStorage();

    String? _token = await _storage.read(key: 'token');

    return _token!;
  }

  // FUNCINO PARA VALIDAR EL  TOKEN,  SI TODAVIA ESTA VIGENTE
  // retorna un true y false

  Future<bool> validateToken( String? token) async {

    // String? token = await storage.read(key: 'token');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-token': token!
    };
    final url = ConectionHost.myUrl('/api/userLogin/validateToken', {});

    final resp = await http.get(url, headers: headers);

    final respBody = json.decode(resp.body);

    if (respBody['valido'] == false) {
      logout();
    }

    // print('Estado delclinte');
    // print(respBody['valido']);
    
    return respBody['valido'];
  }
}
