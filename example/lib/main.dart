import 'dart:io' show Platform;

import 'package:brain_fusion/brain_fusion.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Test(title: 'Flutter Demo Home Page'),
    );
  }
}

class Test extends StatefulWidget {
  final String title;

  const Test({Key? key, required this.title}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final TextEditingController _queryController = TextEditingController();
  final AI ai = AI();
  bool run = false;

  Future<Uint8List> generate(String query) async {
    // Call the runAI method with the required parameters
    Uint8List image = await ai.runAI(query, AIStyle.anime);
    return image;
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double size = Platform.isAndroid || Platform.isIOS
        ? MediaQuery.of(context).size.width
        : MediaQuery.of(context).size.height / 2;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _queryController,
              decoration: const InputDecoration(
                hintText: 'Enter query text...',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: size, //768,
                width: size, //768,
                child: run
                    ? FutureBuilder<Uint8List>(
                        future: generate(_queryController.text), // Call the generate() function to get the image data
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // While waiting for the image data, display a loading indicator
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            // If an error occurred while getting the image data, display an error message
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            // If the image data is available, display the image using Image.memory()
                            return Image.memory(snapshot.data!);
                          } else {
                            // If no data is available, display a placeholder or an empty container
                            return Container();
                          }
                        },
                      )
                    : const Center(
                        child: Text(
                          'Enter Text and Click the button to generate',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String query = _queryController.text;
          if (query.isNotEmpty) {
            setState(() {
              run = true;
            });
          } else {
            if (kDebugMode) {
              print('Query is empty !!');
            }
          }
        },
        tooltip: 'Generate',
        child: const Icon(Icons.gesture),
      ),
    );
  }
}
