import 'dart:convert' show base64;
import 'dart:typed_data' show Uint8List;

import 'package:http/http.dart' as http;

import '../api/run.dart';
import '../api/status.dart';
import 'enums.dart';
import 'webkit_generator.dart';

/// The [AI] class is used to create an instance that can be used to make images by calling the [runAI] function.
///
/// It imports necessary libraries and files from the project's API folder.
///
/// The class has a late initialization of several instance members, including a [http.Client] instance, a [WebKit] instance, and instances of [CheckQueue], [Run], [Status], and [Entities] classes.
///
class AI {
  /// late the [http.Client]
  late http.Client _client;

  /// late the [WebKit]
  late WebKit _webKit;

  /// late the [Run]
  late Run _run;

  /// late the [Status]
  late Status _status;

  /// The constructor initializes the instance members with their respective classes or functions using the client instance member.
  ///
  AI() {
    /// Initialize the class
    _webKit = WebKit();
  }

  /// The [runAI] function is used to create the image, and it requires two parameters: [query], which is the text to be converted into an image, and [AIStyle], which is an enum representing the desired style of the image, and [Resolution], which is an enum representing the resolution of the image.
  ///
  /// The function returns a [Uint8List], which can be used in both Dart and Flutter.
  ///
  /// If any error occurs during this process, an exception is thrown, and the client instance member is closed.
  Future<Uint8List> runAI(
    String query,
    AIStyle style,
    Resolution resolution,
  ) async {
    try {
      /// Initialize the client instance member
      _client = http.Client();

      /// Initialize the classes with the client instance member and pass the [generateBoundaryString] function
      _run = Run(
        client: _client,
        webKit: _webKit.generateBoundaryString(),
      );

      /// Run first Endpoint
      final String UUID = await _run.run(query, style, resolution);
      if (UUID.isEmpty) {
        /// If the [UUID] is empty, an exception is thrown.
        throw Exception('Failed To Get The UUID');
      }

      /// Initialize the classes with the client instance member
      _status = Status(client: _client);

      List<dynamic>? image;
      String? error;
      String? status;
      Map<String, dynamic> data;

      do {
        data = await _status.getStatus(UUID);
        status = data['status'];
        error = data['error'];
        image = data['image'];

        if (error != null) {
          /// If any error occurs during this process, an exception is thrown.
          throw Exception('Failed to generate the image in the server');
        }
        await Future.delayed(const Duration(milliseconds: 200));
      } while (status != 'DONE');
      if (image == null) {
        /// If any error occurs during this process, an exception is thrown.
        throw Exception('Failed to get the image');
      }
      final bytes = base64.decode(image.firstOrNull);

      return bytes;
    } catch (e) {
      /// If any error occurs during this process, an exception is thrown, and the client instance member is closed.
      _client.close();
      throw Exception('Error from AI package: $e');
    }
  }
}
