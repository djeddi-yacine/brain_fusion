/// Importing the 'dart:io' package to detect the platform, the 'brain_fusion' package for AI processing, the 'flutter/foundation.dart' package for debugging, and the 'flutter/material.dart' package for widget building.import 'dart:io' show Platform;
// ignore_for_file: prefer_const_constructors

import 'dart:io' show Platform;
import 'package:brain_fusion/brain_fusion.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// The [main] function is the entry point of the application
void main() {
  /// Call the runApp function to start the app
  runApp(const MyApp());
}

/// The [MyApp] widget is the root widget of the app
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      /// Set the app theme to use Material 3
      theme: ThemeData(
        useMaterial3: true,
      ),

      /// Set the app home page to be the Test widget
      home: const Test(title: 'Example'),
    );
  }
}

/// The [Test] widget.
class Test extends StatefulWidget {
  /// The title of the widget.
  final String title;

  const Test({Key? key, required this.title}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

/// The [_TestState] widget.
class _TestState extends State<Test> {
  /// The text editing controller for the query.
  final TextEditingController _queryController = TextEditingController();

  /// Initializes the [AI] class from the 'brain_fusion' package.
  final AI _ai = AI();

  /// The boolean value to run the function.
  bool run = false;

  /// The [_generate] function to generate image data.
  Future<Uint8List> _generate(String query) async {
    /// Call the runAI method with the required parameters.
    Uint8List image = await _ai.runAI(
      query,
      AIStyle.sovietCartoon,
      Resolution.r1x1,
    );
    return image;
  }

  @override
  void dispose() {
    /// Dispose the [_queryController].
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// The size of the container for the generated image.
    final double size = Platform.isAndroid || Platform.isIOS
        ? MediaQuery.of(context).size.width
        : MediaQuery.of(context).size.height / 2;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                border: Border.all(
                  width: 0.5,
                  color: Colors.grey.shade300,
                ),
              ),
              child: TextField(
                controller: _queryController,
                decoration: InputDecoration(
                  hintText: 'Enter query text...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 8),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: size,
                width: size,
                child: run
                    ? FutureBuilder<Uint8List>(
                        /// Call the [_generate] function to get the image data.
                        future: _generate(_queryController.text),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            /// While waiting for the image data, display a loading indicator.
                            return Center(
                              child: const CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            /// If an error occurred while getting the image data, display an error message.
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            /// If the image data is available, display the image using Image.memory().
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.memory(snapshot.data!),
                            );
                          } else {
                            /// If no data is available, display a placeholder or an empty container.
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
          /// Get the user input from the [_queryController].
          String query = _queryController.text;
          if (query.isNotEmpty) {
            /// If the user input is not empty, set [run] to true to generate the image.
            setState(() {
              run = true;
            });
          } else {
            /// If the user input is empty, print an error message.
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
