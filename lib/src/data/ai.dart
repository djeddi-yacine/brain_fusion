import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../api/entities.dart';
import '../api/check_queue.dart';
import '../api/run.dart';
import '../api/status.dart';
import 'enums.dart';
import 'webkit_generator.dart';

/// init this class in any Widget
/// to use the [runAI] function
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

  AI() {
    /// Initialize the client instance member
    _client = http.Client();

    /// Initialize the class
    _webKit = WebKit();

    /// Initialize the classes with the client instance member
    _checkQueue = CheckQueue(client: _client);

    /// Initialize the classes with the client instance member and pass the [generateBoundaryString] function
    _run = Run(client: _client, webKit: _webKit.generateBoundaryString());

    /// Initialize the classes with the client instance member
    _status = Status(client: _client);

    /// Initialize the classes with the client instance member
    _entities = Entities(client: _client);
  }

  /// Use this function to make the image .
  ///
  /// It required Two parameter the
  /// [query] an [AIStyle] .
  ///
  /// [query] is String text and
  /// [AIStyle] is a style of the image that you want.
  ///
  /// The [runAI] function return a [Uint8List]
  /// so it can be use in both dart and Flutter.
  Future<Uint8List> runAI(
    String query,
    AIStyle style,
  ) async {
    try {
      /// Run First Endpoint and Check
      final bool checker = await _checkQueue.checkQueue();
      if (checker) {
        /// Run Second Endpoint
        await _run.run(query, style);
        bool isSuccess = _run.success;
        String pocketId = _run.pocketId;
        if (isSuccess) {
          String result = 'PROCESSING';

          /// Run 3rd Endpoint
          while (result == 'PROCESSING') {
            await Future.delayed(const Duration(milliseconds: 500));
            await _status.getStatus(pocketId);
            result = _status.result;
          }
          if (result != 'PROCESSING') {
            await _status.getStatus(pocketId);
            bool isLoaded = _status.success;
            if (isLoaded) {
              /// Run 4th Endpoint
              final image = await _entities.getEntities(pocketId);

              /// return the Data
              return image;
            } else {
              _client.close();
              throw Exception('Failed to get status (2) from AI');
            }
          } else {
            _client.close();
            throw Exception('Failed to get status (1) from AI');
          }
        } else {
          _client.close();
          throw Exception('Failed to run AI');
        }
      } else {
        _client.close();
        throw Exception('Failed to check queue in AI');
      }
    } catch (e) {
      _client.close();
      throw Exception('Error from AI package: $e');
    }
  }
}
