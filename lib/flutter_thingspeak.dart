library flutter_thingspeak;

/// FlutterThingspeakClient
class FlutterThingspeakClient {
  final String _serverUrl = "https://api.thingspeak.com";

  /// Channel ID for the channel of interest.
  final String channelID;

  /// Format for the HTTP response, specified as json, xml, or csv.
  String fmt;

  ///Specify Read API Key for this specific channel. Required for private channels
  final String? readApiKey;

  FlutterThingspeakClient(
      {required this.channelID, this.fmt = "json", this.readApiKey});
}
