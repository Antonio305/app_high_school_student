import 'dart:io';

import 'package:file_picker/file_picker.dart';

class PickerFiles {
  // funcion para abriar el cocumento
  // para un solo archivo
  Future pickerFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
if(result != null) {
   File file = File(result.files.single.path!);
} else {
   // User canceled the picker
}
      print('USER CANCELED THE PICKER');
      // print(file.bytes);
      //  print(file.size);
      //  print(file.extension);
  }
}
