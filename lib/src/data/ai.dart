import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../api/entities.dart';
import '../api/check_queue.dart';
import '../api/run.dart';
import '../api/status.dart';
import 'webkit_generator.dart';

/// init this class in any Widget
/// to use the [runAI] function
class AI {
  late http.Client client;
  late WebKit webKit;
  late CheckQueue checkQueue;
  late Run run;
  late Status status;
  late Entities entities;
  AI() {
    // Initialize the client instance member
    client = http.Client();
    // Initialize other classes with the client instance member
    webKit = WebKit();
    checkQueue = CheckQueue(client: client);
    run = Run(client: client, webKit: webKit.generateBoundaryString());
    status = Status(client: client);
    entities = Entities(client: client);
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
      final bool checker = await checkQueue.checkQueue();
      if (checker) {
        await run.run(query, style);
        bool isSuccess = run.success;
        String pocketId = run.pocketId;
        if (isSuccess) {
          String result = 'PROCESSING';
          while (result == 'PROCESSING') {
            await Future.delayed(const Duration(milliseconds: 500));
            await status.getStatus(pocketId);
            result = status.result;
          }
          if (result != 'PROCESSING') {
            await status.getStatus(pocketId);
            bool isLoaded = status.success;
            if (isLoaded) {
              final image = await entities.getEntities(pocketId);
              return image;
            } else {
              client.close();
              throw Exception('Failed to get status (2) from AI');
            }
          } else {
            client.close();
            throw Exception('Failed to get status (1) from AI');
          }
        } else {
          client.close();
          throw Exception('Failed to run AI');
        }
      } else {
        client.close();
        throw Exception('Failed to check queue in AI');
      }
    } catch (e) {
      client.close();
      throw Exception('Error from AI package: $e');
    }
  }
}
/// The [AIStyle] is enum for Famous Styles of Drawing
///
enum AIStyle {
  noStyle,
  anime,
  moreDetails,
  islamic,
  cyberPunk,
  kandinskyPainter,
  aivazovskyPainter,
  malevichPainter,
  picassoPainter,
  goncharovaPainter,
  classicism,
  renaissance,
  oilPainting,
  pencilDrawing,
  digitalPainting,
  medievalStyle,
  render3D,
  cartoon,
  studioPhoto,
  portraitPhoto,
  mosaic,
  iconography,
  khokhlomaPainter,
  christmas,
}
