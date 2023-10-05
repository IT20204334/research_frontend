import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class TrafficMap extends StatefulWidget {
  const TrafficMap({super.key});

  @override
  _TrafficMapState createState() => _TrafficMapState();
}

class _TrafficMapState extends State<TrafficMap> {
  var _channel;
  List<int?> sectionCounts = [null, null, null, null, null, null, null, null];

  @override
  void initState() {
    super.initState();
    _connectWebSocket();
  }

  _connectWebSocket() async {
    _channel = IOWebSocketChannel.connect('ws://10.0.2.2:12345');

    _channel.stream.listen(
      (message) {
        setState(() {
          final matches =
              RegExp(r'Section (\d): (\d+) people').allMatches(message);
          for (final match in matches) {
            final index = int.parse(match.group(1)!) - 1;
            final count = int.parse(match.group(2)!);
            sectionCounts[index] = count;
          }
        });
      },
      onError: (error) {
        setState(() {
          sectionCounts = [null, null, null, null, null, null, null, null];
        });
        Future.delayed(const Duration(seconds: 3), _connectWebSocket);
      },
      onDone: () {
        setState(() {
          sectionCounts = [null, null, null, null, null, null, null, null];
        });
        Future.delayed(const Duration(seconds: 1), _connectWebSocket);
      },
      cancelOnError: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: sectionCounts.contains(null)
              ? const CircularProgressIndicator() // Loading symbol
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    children: sectionCounts.map((count) {
                      final color = (count != null && count > 5)
                          ? Colors.red.withOpacity(0.8) // Translucent Red
                          : Colors.white.withOpacity(0.8); // Translucent White
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: color,
                        ),
                        child: Center(
                          child: Text(
                            count?.toString() ?? '',
                            style: const TextStyle(
                                fontSize: 36, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _channel?.sink?.close();
    super.dispose();
  }
}
