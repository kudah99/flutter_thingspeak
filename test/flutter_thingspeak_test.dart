import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_thingspeak/flutter_thingspeak.dart';

void main() {
  test('FlutterThingspeakClient class tests', () async {
    final flutterThingspeak = FlutterThingspeakClient(channelID: '12397');

    // Test initialization
    await flutterThingspeak.initialize();
    expect(flutterThingspeak.readApiKey,
        isNull); // Assuming readApiKey is not provided

    // Test get method after initialization
    final result = await flutterThingspeak.get();
    // You might want to customize this expectation based on your actual response
    expect(result, isNotNull);

    // Test uninitialized client
    final uninitializedClient = FlutterThingspeakClient(channelID: '456');
    try {
      await uninitializedClient.get();
      // The test should not reach this point, throw an error if it does.
      fail('Exception expected');
    } catch (e) {
      expect(e, isA<ClientNotInitializedException>());
      expect((e as ClientNotInitializedException).message,
          'Client not initialized.');
    }
  });
}
