import 'package:flutter/material.dart';
import 'package:flutter_thingspeak/flutter_thingspeak.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import './channel_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Thingspeak demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final flutterThingspeak = FlutterThingspeakClient(
      channelID: '12397', options: {'results': '5', 'timescale': '5'});
  Channel? channel;
  List<Feed> feeds = <Feed>[];

  Future<void> getTemperatureData() async {
    flutterThingspeak.initialize();
    try {
      // Get data from the ThingSpeak channel
      final result = await flutterThingspeak.getFieldData('4');
      print(result);

      channel = Channel.fromJson(result);
      feeds = (result['feeds'] as List<dynamic>)
          .map((feed) => Feed.fromJson(feed))
          .toList();
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: getTemperatureData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                // Display an error message if there was an error fetching data
                return Center(
                  child: Text('Error loading data: ${snapshot.error}'),
                );
              }

              if (channel != null) {
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45, width: .5),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: ListBody(
                        children: [
                          ListTile(
                            title: Text("Channel ID"),
                            subtitle: Text(channel!.id.toString()),
                          ),
                          ListTile(
                            title: Text("Channel Name"),
                            subtitle: Text(channel!.name),
                          ),
                          ListTile(
                            title: Text("Channel Description"),
                            subtitle: Text(channel!.description),
                          ),
                          ListTile(
                            title: Text("Location"),
                            subtitle: Text(
                                "${channel!.latitude.toString()},${channel!.longitude}"),
                          )
                        ],
                      ),
                    ),
                    SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        // Chart title
                        title: ChartTitle(text: 'Temperature Data Chart'),
                        // Enable legend
                        legend: Legend(isVisible: true),
                        // Enable tooltip
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <CartesianSeries<Feed, String>>[
                          LineSeries<Feed, String>(
                              dataSource: feeds,
                              xValueMapper: (Feed feed, _) =>
                                  feed.createdAt.minute.toString(),
                              yValueMapper: (Feed feed, _) => feed.field4,
                              name: 'Temperature',
                              // Enable data label
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true))
                        ]),
                  ],
                );
              } else {
                // Display a message when data is not available
                return Center(
                  child: Text('No data available.'),
                );
              }
            } else {
              // Display a loading indicator while data is being fetched
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
