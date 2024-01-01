# Flutter ThingSpeak

Flutter ThingSpeak is a Dart package that provides a client for interacting with 
ThingSpeak channels.Covers all functionalities of the ThingSpeak API, enabling users to update channel
 information, fetch and analyze feeds, and query public channels.
Compatible with both the hosted ThingSpeak server at api.thingspeak.com and self-hosted open-source servers.

## Getting Started

To use this package, add `flutter_thingspeak` as a dependency in your `pubspec.yaml` file.

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
  final result = await flutterThingspeak.get();
  print(result);
}
```

## Example

For a more detailed example, check the `/example` folder in this repository.

## Additional Information

- [Package on pub.dev](https://pub.dev/packages/flutter_thingspeak)
- [Report Issues](https://github.com/kudah99/flutter_thingspeak/issues)
- [Contribute](https://github.com/kudah99/flutter_thingspeak/contributing)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
```