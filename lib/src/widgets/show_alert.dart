
import 'package:flutter/material.dart';


class ShowAlert {

   static  void showAlert(BuildContext context, String title, Widget content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SizedBox(
          
           height: 200,
          child: content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("ACEPTAR"),
          ),
        ],
      );
    },
  );
}

}