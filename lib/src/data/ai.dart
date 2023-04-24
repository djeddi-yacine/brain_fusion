import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../api/entities.dart';
import '../api/check_queue.dart';
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

  /// late the [CheckQueue]
  late CheckQueue _checkQueue;

  /// late the [Run]
  late Run _run;

  /// late the [Status]
  late Status _status;

  /// late the [Entities]
  late Entities _entities;

  /// The constructor initializes the instance members with their respective classes or functions using the client instance member.
  ///
  AI() {
    /// Initialize the class
    _webKit = WebKit();
  }

  /// The [runAI] function is used to create the image, and it requires two parameters: [query], which is the text to be converted into an image, and [AIStyle], which is an enum representing the desired style of the image.
  ///
  /// The function returns a [Uint8List], which can be used in both Dart and Flutter.
  ///
  /// The function first calls the [checkQueue] function of the [CheckQueue] instance member to check the queue. If the queue is not busy, the [run] function of the [Run] instance member is called with the [query] and [AIStyle] parameters. After this, the [getStatus] function of the [Status] instance member is called in a loop to check the status of the image generation process until it is completed. Finally, the [getEntities] function of the [Entities] instance member is called to retrieve the image data and return it as a [Uint8List].
  ///
  /// If any error occurs during this process, an exception is thrown, and the client instance member is closed.
  Future<Uint8List> runAI(
    String query,
    AIStyle style,
  ) async {
    try {
      /// Initialize the client instance member
      _client = http.Client();

      /// Initialize the classes with the client instance member
      _checkQueue = CheckQueue(client: _client);

      /// Run First Endpoint and Check
      final bool checker = await _checkQueue.checkQueue();
      if (checker) {
        /// Initialize the classes with the client instance member and pass the [generateBoundaryString] function
        _run = Run(
          client: _client,
          webKit: _webKit.generateBoundaryString(),
        );

        /// Run Second Endpoint
        await _run.run(query, style);
        bool isSuccess = _run.success;
        String pocketId = _run.pocketId;
        if (isSuccess) {
          String result = '';

          /// Initialize the classes with the client instance member
          _status = Status(client: _client);

          /// Run 3rd Endpoint
          while (result != 'SUCCESS') {
            await Future.delayed(const Duration(milliseconds: 200));
            await _status.getStatus(pocketId);
            result = _status.result;
          }
          if (result == 'SUCCESS') {
            await _status.getStatus(pocketId);
            bool isLoaded = _status.success;
            if (isLoaded) {
              /// Initialize the classes with the client instance member
              _entities = Entities(client: _client);

              /// Run 4th Endpoint
              final image = await _entities.getEntities(pocketId);

              /// return the Data
              return image;
            } else {
              /// If any error occurs during this process, an exception is thrown, and the client instance member is closed.
              _client.close();
              throw Exception('Failed to get status (2) from AI');
            }
          } else {
            /// If any error occurs during this process, an exception is thrown, and the client instance member is closed.
            _client.close();
            throw Exception('Failed to get status (1) from AI');
          }
        } else {
          /// If any error occurs during this process, an exception is thrown, and the client instance member is closed.
          _client.close();
          throw Exception('Failed to run AI');
        }
      } else {
        /// If any error occurs during this process, an exception is thrown, and the client instance member is closed.
        _client.close();
        throw Exception('Failed to check queue in AI');
      }
    } catch (e) {
      /// If any error occurs during this process, an exception is thrown, and the client instance member is closed.
      _client.close();
      throw Exception('Error from AI package: $e');
    }
  }
}
