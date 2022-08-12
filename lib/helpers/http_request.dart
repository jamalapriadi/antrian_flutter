import 'dart:async';

import 'package:http/http.dart' show Client;

class Network {
  Client client = Client();

  static const String accept = 'application/json';
  static const String contentType = 'application/x-www-form-urlencoded';

  Future<dynamic> getRequest(String url) async {
    try {
      final response = await client.get(Uri.parse(url), headers: {
        'content-type': contentType,
        'accept': accept,
      }).timeout(const Duration(seconds: 20));

      return response;
    } on TimeoutException catch (_) {
      throw Exception();
    }
  }

  Future<dynamic> postRequest(String url, Map<String, dynamic> body) async {
    try {
      final response = await client.post(Uri.parse(url),
          headers: {
            'content-type': contentType,
            'accept': accept,
          },
          body: body);

      if (response.statusCode == 401) {
        throw Exception('${response.statusCode}');
      }

      return response;
    } on TimeoutException catch (_) {
      throw Exception();
    }
  }
}
