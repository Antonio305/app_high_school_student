import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;
import 'package:prepa_estudiantes/src/model/host.dart';

class FilesServices extends ChangeNotifier {
// variablaes para las descargar
  double porcentDownload = 0.0;
  String? downloadMessage = 'INITIZALIZED .......';
  bool isDownloading = false;

// for status
  bool status = false;

// intnacia de la clase url la cual esta definidido el host
  final String baseUrl = ConectionHost.baseUrl;

// crate function for uplod file
// taskReceived
  Future uploadFiles(File? pathFile, String id, String collection) async {
    // require token, id, collection
    final Map<String, String> headers = {
      // 'ContentType':
    };

    // final url = Uri.http(baseUrl, '/api/uploadFile/${id}/${collection}');
    final url = ConectionHost.myUrl('/api/uploadFile/${id}/${collection}', {});
    // cheamos si hay arhcivos, para ver si no es nulo
    if (pathFile == null) {
      print('No hay aarchivos seleccionados');
      return null;
    }
    // newFile
    status = true;
    notifyListeners();

    var fileUploadRequest = http.MultipartRequest('PUT', url);
    // add path file
    final file = await http.MultipartFile.fromPath('archivo', pathFile.path);

    // add file for sendd
    fileUploadRequest.files.add(file);

    // repuesta
    final streamedResponse = await fileUploadRequest.send();

    final resp = await http.Response.fromStream(streamedResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      return null;
    }

    status = false;
    notifyListeners();
    print('todo dalio bien');
    pathFile = null;
  }

  // funcionp para descargar en android
  // desccargar sin libreria
  // Future<void> descargarArchivo(
  //     String urlDescarga, String nombreArchivo) async {
  //   var request = await http.get(Uri.parse(urlDescarga));

  //   var bytes = request.bodyBytes;
  //   var dir = await getExternalStorageDirectory();
  //   File archivo = File("${dir!.path}/$nombreArchivo");
  //   await archivo.writeAsBytes(bytes);
  // }

// TODO: ESTA FUCION SI sirve pero no se esta usando

// funci para descargar los archibos
  double progresoDescarga = 0;

  Future<void> downloadImage(String urls, String filename) async {
    // directorio ara guardar la imagen
    Directory docDir = await getApplicationDocumentsDirectory();
    print(docDir.path);

    // el url tiene que estar parseado

    final Uri? url = Uri.parse(urls);
    
    if (url == null) {
      return null;
    }

    status = true;
    notifyListeners();


    var response = await http.get(url);
    //  var request = await http.get(Uri.parse(widget.urlDescarga));
    // var bytes = request.bodyBytes;

    var pathList = docDir.path.split('\\');
    // pathList[pathList.length - 1] = 'Pictures';
    pathList[pathList.length - 1] = 'Downloads';

    var picturePath = pathList.join('\\');
    print("dicrectorio : $picturePath");

    // String filename = 'gayoti.pdf';

    // thetaIMage = File
    // para crar el directori ode donde se guarda el archivo
    var thetaImage =
        await File(join(picturePath, filename)).create(recursive: true);

    await thetaImage.writeAsBytes(response.bodyBytes);

    status = false;
    notifyListeners();

    print('Directorio : $thetaImage');
  }


// // creamso una function de tipo Stream para la animacino de la descarga
//   Stream<double> getStream() {
//     return Stream.periodic(const Duration(milliseconds: 100), (count) {
//       progresoDescarga += 0.01;
//       return progresoDescarga;
//     }).takeWhile((value) => value >= 1.0);
//   }

// dowload file with animacion progress

  Future downloadFiles(String urls, String namefile) async {
    // setState(() {
    // });
    isDownloading = true;
    notifyListeners();

    Dio dio = Dio();
    String filename = 'progresssVidio.mp4';
    String url =
        "https://jsoncompare.org/LearningContainer/SampleFiles/Video/MP4/sample-mp4-file.mp4";
    // String url =
    // "https://www.mundogatos.com/Uploads/mundogatos.com/ImagenesGrandes/fotos-de-gatitos-7.jpg";
    // await fileServices.downloadImage(
    //     url, 'panchitogatito.jpg');
    // print(
    //     'FOTO DE PANCHITO HA SICO DESCARGADO');

    // para WINDOWS
    Directory docDir = await getApplicationDocumentsDirectory();
    var pathList = docDir.path.split('\\');
    // pathList[pathList.length - 1] = 'Pictures';
    pathList[pathList.length - 1] = 'Downloads';
    var picturePath = pathList.join('\\');
    File thetaImage =
        // await File(join(picturePath, filename));
        await File(join(picturePath, filename)).create(recursive: true);
    // await thetaImage
    //     .writeAsBytes(response.bodyBytes);
    /// instancia de dio para la descargar de archivos
    print(" path para guardar el archivo :  ${thetaImage}");
    // if (thetaImage.existsSync()) {
    //   print('El archivo ya existe');
    //   return null;
    // }

    await dio.download(url, '${thetaImage.path}',
        onReceiveProgress: (actualbytes, totalbytes) {
      var percentage = actualbytes / totalbytes * 100;
      porcentDownload = percentage / 100;

      // setState(() {
      // });
      downloadMessage = 'Dowloading .... ${percentage.floor()} %';
      notifyListeners();
    });
  }
}
