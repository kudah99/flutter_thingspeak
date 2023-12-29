library flutter_thingspeak;

import 'package:flutter_thingspeak/services/read_data_service.dart';

/// Client for interacting with ThingSpeak channels.
///
/// This client provides methods to read data from ThingSpeak channels.
class FlutterThingspeakClient {
  final String _serverUrl = "api.thingspeak.com";

  /// The ID of the ThingSpeak channel.
  final String channelID;

  /// The format for the HTTP response, specified as json, xml, or csv.
  String fmt;

  /// Read API Key for this specific channel. Required for private channels.
  final String? readApiKey;

  ReadDataService? _readDataService;

  /// Constructs a [FlutterThingspeakClient] with the specified parameters.
  ///
  /// [channelID] is the ID of the ThingSpeak channel.
  /// [fmt] is the format for the HTTP response, specified as json, xml, or csv (default is json).
  /// [readApiKey] is the Read API Key for this specific channel. Required for private channels.
  FlutterThingspeakClient({
    required this.channelID,
    this.fmt = "json",
    this.readApiKey,
  });

  /// Initializes the client by creating an instance of [ReadDataService].
  Future<void> initialize() async {
    _readDataService = ReadDataService(
        serverUrl: _serverUrl, id: channelID, fmt: fmt, apiKey: readApiKey);
  }

  /// Read data from all fields in channel
  ///
  /// Throws [ClientNotInitializedException] if the client has not been initialized.
  Future<dynamic> get() async {
    if (_readDataService == null) {
      throw ClientNotInitializedException(message: "Client not initialized.");
    } else {
      return await _readDataService!.get();
    }
  }

  /// Read data from single [field] of channel
  ///
  /// Throws [ClientNotInitializedException] if the client has not been initialized.
  Future<dynamic> getField(String field) async {
    if (_readDataService == null) {
      throw ClientNotInitializedException(message: "Client not initialized.");
    } else {
      return await _readDataService!.getField(field);
    }
  }

  /// Read status field of channel
  ///
  /// Throws [ClientNotInitializedException] if the client has not been initialized.
  Future<dynamic> getStatus() async {
    if (_readDataService == null) {
      throw ClientNotInitializedException(message: "Client not initialized.");
    } else {
      return await _readDataService!.getStatus();
    }
  }

  /// Read last entry in channel field
  /// Throws [ClientNotInitializedException] if the client has not been initialized.
  Future<dynamic> getLastDataAge(String field) async {
    if (_readDataService == null) {
      throw ClientNotInitializedException(message: "Client not initialized.");
    } else {
      return await _readDataService!.getLastDataAge(field);
    }
  }

  /// Read last status of channel
  ///
  /// Throws [ClientNotInitializedException] if the client has not been initialized.
  Future<dynamic> getLastStatusAge() async {
    if (_readDataService == null) {
      throw ClientNotInitializedException(message: "Client not initialized.");
    } else {
      return await _readDataService!.getLastStatusAge();
    }
  }
}

/// Exception thrown when the client is not initialized.
class ClientNotInitializedException implements Exception {
  /// The exception message.
  final String message;

  /// Constructs a [ClientNotInitializedException] with the specified [message].
  ClientNotInitializedException({required this.message});
}
