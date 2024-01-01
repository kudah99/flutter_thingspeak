import 'dart:convert';
import 'package:http/http.dart' as http;

class ReadDataService {
  String id;
  String? apiKey;
  String fmt;
  String serverUrl;
  bool isPrivate;
  Map<String, dynamic>? options;

  ReadDataService(
      {required this.serverUrl,
      required this.id,
      this.apiKey,
      required this.fmt,
      this.isPrivate = false,
      this.options});

  Future<dynamic> get() async {
    options ??= {};
    if (apiKey != null) {
      options!['api_key'] = apiKey;
    }
    var path = 'channels/$id/feeds.$fmt';
    Uri endpoint = Uri.https(serverUrl, path, options);
    var response = await http.get(endpoint);
    return _fmt(response);
  }

  Future<dynamic> getField(
    String field,
  ) async {
    options ??= {};
    if (apiKey != null) {
      options!['api_key'] = apiKey;
    }
    var path = 'channels/$id/fields/$field.$fmt';
    Uri endpoint = Uri.https(serverUrl, path, options);
    var response = await http.get(endpoint);
    return _fmt(response);
  }

  Future<dynamic> getStatus() async {
    options ??= {};
    if (apiKey != null) {
      options!['api_key'] = apiKey;
    }
    var path = 'channels/$id/status.$fmt';
    Uri endpoint = Uri.https(serverUrl, path, options);
    var response = await http.get(endpoint);
    return _fmt(response);
  }

  Future<dynamic> getLastDataAge(
    String field,
  ) async {
    options ??= {};
    if (apiKey != null) {
      options!['api_key'] = apiKey;
    }
    var path = 'channels/$id/fields/$field/last.$fmt';
    Uri endpoint = Uri.https(serverUrl, path, options);
    var response = await http.get(endpoint);
    return _fmt(response);
  }

  Future<dynamic> getLastStatusAge() async {
    options ??= {};
    if (apiKey != null) {
      options!['api_key'] = apiKey;
    }
    var path = 'channels/$id/status/last.$fmt';
    Uri endpoint = Uri.https(serverUrl, path, options);
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
