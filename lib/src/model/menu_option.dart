import 'package:flutter/cupertino.dart';

class OptionMenu {
//datos
// nombre de la ruta
// icon
// string name
// widget screen  o la pagina

  final String route;
  final IconData icon;
  final String name;
  final Widget screen;

// En el contrucctor vamos a recivir los datos

  OptionMenu(
      {required this.route,
      required this.icon,
      required this.name,
      required this.screen});
}
