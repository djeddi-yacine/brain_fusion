/// This is the implementation of the [Run] class. It provides a function [run] that sends a query to an AI service and returns a map of the success status and the ID of the generated image.

import 'dart:convert' show json, utf8;
import 'package:http/http.dart' as http;
import '../data/enums.dart';
import '../data/strings.dart';

/// The [Run] class is used to start the generation process.
class Run {
  /// The [webKit] string is used to set the boundary for the multipart/form-data request.
  final String webKit;

  /// The [client] is an http client used to send requests.
  final http.Client client;

  Run({required this.client, required this.webKit});

  ///Create [getStyle] function to pass the style
  String getStyle(AIStyle? aiStyle) {
    switch (aiStyle) {
      case AIStyle.noStyle:
        return 'DEFAULT';
      case AIStyle.anime:
        return 'ANIME';
      case AIStyle.moreDetails:
        return 'UHD';
      case AIStyle.cyberPunk:
        return 'CYBERPUNK';
      case AIStyle.kandinskyPainter:
        return 'KANDINSKY';
      case AIStyle.aivazovskyPainter:
        return 'AIVAZOVSKY';
      case AIStyle.malevichPainter:
        return 'MALEVICH';
      case AIStyle.picassoPainter:
        return 'PICASSO';
      case AIStyle.goncharovaPainter:
        return 'GONCHAROVA';
      case AIStyle.classicism:
        return 'CLASSICISM';
      case AIStyle.renaissance:
        return 'RENAISSANCE';
      case AIStyle.oilPainting:
        return 'OILPAINTING';
      case AIStyle.pencilDrawing:
        return 'PENCILDRAWING';
      case AIStyle.digitalPainting:
        return 'DIGITALPAINTING';
      case AIStyle.medievalStyle:
        return 'MEDIEVALPAINTING';
      case AIStyle.render3D:
        return 'RENDER';
      case AIStyle.cartoon:
        return 'CARTOON';
      case AIStyle.studioPhoto:
        return 'STUDIOPHOTO';
      case AIStyle.portraitPhoto:
        return 'PORTRAITPHOTO';
      case AIStyle.khokhlomaPainter:
        return 'KHOKHLOMA';
      case AIStyle.christmas:
        return 'CRISTMAS';
      default:
        return 'DEFAULT';
    }
  }

  ///Create [getResolution] function to pass the [Resolution]
  (String, String) getResolution(Resolution? resolution) {
    switch (resolution) {
      case Resolution.r1x1:
        return ('1024', '1024');
      case Resolution.r2x3:
        return ('680', '1024');
      case Resolution.r3x2:
        return ('1024', '680');
      case Resolution.r9x16:
        return ('576', '1024');
      case Resolution.r16x9:
        return ('1024', '576');
      default:
        return ('1024', '1024');
    }
  }

  /// This [run] function runs the query with the chosen [AIStyle] and returns a map of the success status and the ID of the generated image.
  ///
  /// The [query] parameter is a string that contains the query for the AI service.
  ///
  /// The [style] parameter is an enum that represents the style of the generated image.
  ///
  /// The function returns a [Map<String, dynamic>] that contains the success status and the ID of the generated image.
  Future<String> run(
      String query, AIStyle? style, Resolution? resolution) async {
    /// The [apiUrl] is a new [Uri] that is parsed from the [runAPI] string constant.
    final Uri apiUrl = Uri.parse(runAPI);

    /// This [headers] map is used to set the headers for the http request.
    final headers = {
      'Accept': '*/*',
      'Accept-Language': 'en-US,en;q=0.9,en-GB;q=0.8',
      'Cache-Control': 'no-cache',
      'Connection': 'keep-alive',
      'Content-Type': 'multipart/form-data; boundary=$webKit',
      'Origin': origin,
      'Pragma': 'no-cache',
      'Referer': referer,
      'User-Agent': userAgent,
      'sec-ch-ua': secChUa,
    };

    /// The [requestData] string is used to set the data for the http request.
    final requestData =
        '''--$webKit\r\nContent-Disposition: form-data; name="params"; filename="blob"\r\nContent-Type: application/json\r\n\r\n{"type":"GENERATE","style":"${getStyle(style)}","width":${getResolution(resolution).$1},"height":${getResolution(resolution).$2},"generateParams":{"query":"$query"}}\r\n--$webKit--''';

    /// This [response] variable is used to store the http response.
    var response = await client.post(apiUrl,
        headers: headers, body: requestData, encoding: utf8);

    /// Check the http status code of the response and return the appropriate response.
    if (response.statusCode == 201 || response.statusCode == 200) {
      /// Decode the body.
      final jsonResponse = json.decode(response.body);

      /// This [uuid] string is used to store the ID of the generated image.
      final String? uuid = jsonResponse['uuid'] as String;

      ///return [uuid]
      return uuid ?? '';
    } else if (response.statusCode != 201 || response.statusCode != 200) {
      /// Throw an exception if the response status code is not 200 or 201
      throw Exception('run code : ${response.statusCode}');
    } else {
      /// Throw an exception if there was a failure to fetch the run
      throw Exception('Failed to make run');
    }
  }
}
