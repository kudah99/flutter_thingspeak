library flutter_thingspeak;

import 'package:flutter_thingspeak/services/read_data_service.dart';

/// A Flutter library for interacting with ThingSpeak channels to read data.
///
/// The [FlutterThingspeakClient] provides methods to read data from ThingSpeak channels,
/// including reading all fields, a specific field, status field, last data entry, and last status entry.
///
/// To use this library, create an instance of [FlutterThingspeakClient] with the required parameters,
/// initialize it using [initialize], and then use the provided methods to retrieve data from ThingSpeak channels.
class FlutterThingspeakClient {
  final String _serverUrl = "api.thingspeak.com";

  /// The ID of the ThingSpeak channel.
  final String channelID;

  /// The format for the HTTP response, specified as json, xml, or csv (default is json).
  String fmt;

  /// Read API Key for this specific channel. Required for private channels.
  final String? readApiKey;

  /// Additional query parameters for the API request.
  final Map<String, dynamic>? options;

  ReadDataService? _readDataService;

  /// Constructs a [FlutterThingspeakClient] with the specified parameters.
  ///
  /// - [channelID]: The ID of the ThingSpeak channel.
  /// - [fmt]: The format for the HTTP response, specified as json, xml, or csv (default is json).
  /// - [readApiKey]: Read API Key for private channels.
  /// - [options]: Additional query parameters for the API request.
  FlutterThingspeakClient({
    required this.channelID,
    this.fmt = "json",
    this.readApiKey,
    this.options,
  });

  /// Initializes the client by creating an instance of [ReadDataService].
  ///
  /// This method should be called before using any other methods.
  Future<void> initialize() async {
    _readDataService = ReadDataService(
      serverUrl: _serverUrl,
      id: channelID,
      fmt: fmt,
      apiKey: readApiKey,
      options: options,
    );
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

  /// Read data from all fields in the channel.
  ///
  /// Throws a [ClientNotInitializedException] if the client has not been initialized.
  Future<dynamic> getAllData() async {
    if (_readDataService == null) {
      throw ClientNotInitializedException(message: "Client not initialized.");
    } else {
      return await _readDataService!.get();
    }
  }

  /// Read data from a specific [field] in the channel.
  ///
  /// Throws a [ClientNotInitializedException] if the client has not been initialized.
  Future<dynamic> getFieldData(String field) async {
    if (_readDataService == null) {
      throw ClientNotInitializedException(message: "Client not initialized.");
    } else {
      return await _readDataService!.getField(field);
    }
  }

  /// Read the status field of the channel.
  ///
  /// Throws a [ClientNotInitializedException] if the client has not been initialized.
  Future<dynamic> getStatus() async {
    if (_readDataService == null) {
      throw ClientNotInitializedException(message: "Client not initialized.");
    } else {
      return await _readDataService!.getStatus();
    }
  }

  /// Read the last entry in a specific [field] of the channel.
  ///
  /// Throws a [ClientNotInitializedException] if the client has not been initialized.
  Future<dynamic> getLastDataAge(String field) async {
    if (_readDataService == null) {
      throw ClientNotInitializedException(message: "Client not initialized.");
    } else {
      return await _readDataService!.getLastDataAge(field);
    }
  }

  /// Read the last status entry of the channel.
  ///
  /// Throws a [ClientNotInitializedException] if the client has not been initialized.
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
