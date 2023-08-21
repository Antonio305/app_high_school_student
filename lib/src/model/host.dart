import 'package:http/http.dart' as http;

class ConectionHost {
  static String baseUrl = "192.168.1.66:3000";




  static   myUrl(String path, Map<String, dynamic>? query) {
    Uri url = Uri.http(baseUrl, path);
    // final url = Uri.https('prepabochil.fly.dev', path);

    return url;
  }

}
