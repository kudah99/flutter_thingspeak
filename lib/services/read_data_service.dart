import 'dart:convert';
import 'package:http/http.dart' as http;

class ReadDataService {
  String id;
  String? apiKey;
  String fmt;
  String serverUrl;

  ReadDataService({
    required this.serverUrl,
    required this.id,
    this.apiKey,
    required this.fmt,
  });

  Future<dynamic> get({Map<String, dynamic>? options}) async {
    options ??= {};
    if (apiKey != null) {
      options['api_key'] = apiKey;
    }
    var path = 'channels/$id/feeds.$fmt';
    Uri endpoint = Uri.https(serverUrl, path);
    var response = await http.get(endpoint);
    return _fmt(response);
  }

  dynamic _fmt(http.Response r) {
    if (r.statusCode == 200) {
      if (fmt == 'json') {
        return json.decode(r.body);
      } else {
        return r.body;
      }
    } else {
      throw Exception('Failed to fetch data: ${r.reasonPhrase}');
    }
  }
}
