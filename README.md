# Flutter ThingSpeak

Flutter ThingSpeak is a Dart package that provides a client for interacting with ThingSpeak channels. 
It covers all functionalities of the ThingSpeak API, enabling users to update channel information,
 fetch and analyze feeds, and query public channels. It is compatible with both the hosted 
 ThingSpeak server at `api.thingspeak.com` and self-hosted open-source servers.

## Getting Started

To use this package, add `flutter_thingspeak` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_thingspeak: ^1.1.0
```

Then run:

```bash
dart pub get
```

## Usage

```dart
import 'package:flutter_thingspeak/flutter_thingspeak.dart';

void main() async {
  final flutterThingspeak = FlutterThingspeakClient(channelID: '12397');

  // Initialize the client
  await flutterThingspeak.initialize();

  // Get data from the ThingSpeak channel
  final result = await flutterThingspeak.getAllData();
  print(result);
}
```

## Query Parameters

These are optional query parameters that can be included in the [options] parameter
when making requests to the ThingSpeak API. They allow you to customize the response
based on specific criteria.

- For detailed information about the query parameters, please refer to the
[ThingSpeak Read Data Documentation](https://www.mathworks.com/help/thingspeak/readdata.html).

```dart
String results; // Number of entries to retrieve. The maximum number is 8,000.
String days; // Number of 24-hour periods before now to include in response. The default is 1.
String minutes; // Number of 60-second periods before now to include in response. The default is 1440.
String start; // Start date in format YYYY-MM-DD%20HH:NN:SS.
String end; // End date in format YYYY-MM-DD%20HH:NN:SS.
String timezone; // Identifier from Time Zones Reference for this request.
String offset; // Timezone offset that results are displayed in. Use the timezone parameter for greater accuracy.
String status; // Include status updates in feed by setting "status=true".
String metadata; // Include metadata for a channel by setting "metadata=true".
String location; // Include latitude, longitude, and elevation in feed by setting "location=true".
String min; // Minimum value to include in response.
String max; // Maximum value to include in response.
String round; // Round to this many decimal places.
String timescale; // Get first value in this many minutes, valid values: 10, 15, 20, 30, 60, 240, 720, 1440, "daily".
String sum; // Get sum of this many minutes, valid values: 10, 15, 20, 30, 60, 240, 720, 1440, "daily".
String average; // Get average of this many minutes, valid values: 10, 15, 20, 30, 60, 240, 720, 1440, "daily".
String median; // Get median of this many minutes, valid values: 10, 15, 20, 30, 60, 240, 720, 1440, "daily".
```

## Example

For a more detailed example, check the `/example` folder in this repository.

## Additional Information

- [Package on pub.dev](https://pub.dev/packages/flutter_thingspeak)
- [Report Issues](https://github.com/kudah99/flutter_thingspeak/issues)
- [Contribute](https://github.com/kudah99/flutter_thingspeak/blob/main/CONTRIBUTING.md)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
```