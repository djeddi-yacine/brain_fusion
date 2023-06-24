/// This is the implementation of the [Run] class. It provides a function [run] that sends a query to an AI service and returns a map of the success status and the ID of the generated image.

import 'dart:convert';
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

  /// This [success] boolean variable is used to check the success status of the generation process.
  bool success = false;

  /// This [pocketId] string is used to store the ID of the generated image.
  String pocketId = '';

  ///Create [getStyle] function to pass the style
  String getStyle(AIStyle aiStyle) {
    ///Create empty String
    String style = '';

    /// Switch statement to handle different AI styles
    switch (aiStyle) {
      ///if [AIStyle.noStyle], return an empty style string
      case AIStyle.noStyle:
        style = '';
        break;

      ///if [AIStyle.anime], return a style string with anime style description
      case AIStyle.anime:
        style = 'in anime style';
        break;

      ///if [AIStyle.moreDetails], return a style string with 4k, ultra HD, detailed photo description
      case AIStyle.moreDetails:
        style = '4k, ultra HD, detailed photo';
        break;

      ///if [AIStyle.cyberPunk], return a style string with cyberpunk style and futuristic cyberpunk description
      case AIStyle.cyberPunk:
        style = 'in cyberpunk style, futuristic cyberpunk';
        break;

      ///if [AIStyle.kandinskyPainter], return a style string painted by Vasily Kandinsky and abstractionism description
      case AIStyle.kandinskyPainter:
        style = 'painted by Vasily Kandinsky, abstractionism';
        break;

      ///if [AIStyle.aivazovskyPainter], return a style string painted by Aivazovsky description
      case AIStyle.aivazovskyPainter:
        style = 'painted by Aivazovsky';
        break;

      ///if [AIStyle.malevichPainter], return a style string with Malevich, suprematism, avant-garde art, 20th century, geometric shapes , colorful, Russian avant-garde description
      case AIStyle.malevichPainter:
        style =
            'Malevich, suprematism, avant-garde art, 20th century, geometric shapes , colorful, Russian avant-garde';
        break;

      ///if [AIStyle.picassoPainter], return a style string with Cubist painting by Pablo Picasso, 1934, colourful description
      case AIStyle.picassoPainter:
        style = 'Cubist painting by Pablo Picasso, 1934, colourful';
        break;

      ///if [AIStyle.goncharovaPainter], return a style string painted by Goncharova and Russian avant-garde, futurism, cubism, suprematism description
      case AIStyle.goncharovaPainter:
        style =
            'painted by Goncharova, Russian avant-garde, futurism, cubism, suprematism';
        break;

      ///if [AIStyle.classicism], return a style string with classicism painting, 17th century, trending on artstation, baroque painting description
      case AIStyle.classicism:
        style =
            'classicism painting, 17th century, trending on artstation, baroque painting';
        break;

      ///if [AIStyle.renaissance], return a style string with painting, renaissance old master royal collection, artstation description
      case AIStyle.renaissance:
        style = 'painting, renaissance old master royal collection, artstation';
        break;

      ///if [AIStyle.oilPainting], return a style string with like oil painting description
      case AIStyle.oilPainting:
        style = 'like oil painting';
        break;

      ///if [AIStyle.pencilDrawing], return a style string with pencil art, pencil drawing, highly detailed description
      case AIStyle.pencilDrawing:

        ///return
        style = 'pencil art, pencil drawing, highly detailed';
        break;

      /// For digital painting style
      case AIStyle.digitalPainting:

        /// Set the style string for digital painting
        style =
            'high quality, highly detailed, concept art, digital painting, by greg rutkowski trending on artstation';
        break;

      /// For medieval painting style
      case AIStyle.medievalStyle:

        /// Set the style string for medieval painting
        style = 'medieval painting, 15th century, trending on artstation';
        break;

      /// For 3D rendering style
      case AIStyle.render3D:

        /// Set the style string for 3D rendering
        style =
            'Unreal Engine rendering, 3d render, photorealistic, digital concept art, octane render, 4k HD';
        break;

      /// For cartoon style
      case AIStyle.cartoon:

        /// Set the style string for cartoon
        style = 'as cartoon, picture from cartoon';
        break;

      /// For studio photo style
      case AIStyle.studioPhoto:

        /// Set the style string for studio photo
        style =
            'glamorous, emotional ,shot in the photo studio, professional studio lighting, backlit, rim lighting, 8k';
        break;

      /// For portrait photo style
      case AIStyle.portraitPhoto:

        /// Set the style string for portrait photo
        style = '50mm portrait photography, hard rim lighting photography';
        break;

      /// For mosaic style
      case AIStyle.mosaic:

        /// Set the style string for mosaic
        style = 'as tile mosaic';
        break;

      /// For iconography style
      case AIStyle.iconography:

        /// Set the style string for iconography
        style =
            'in the style of a wooden christian medieval icon in the church';
        break;

      /// For Khokhloma painter style
      case AIStyle.khokhlomaPainter:

        /// Set the style string for Khokhloma painter style
        style =
            'in Russian style, Khokhloma, 16th century, marble, decorative, realistic';
        break;

      /// For Christmas style
      case AIStyle.christmas:

        /// Set the style string for Christmas style
        style =
            'christmas, winter, x-mas, decorations, new year eve, snowflakes, 4k';
        break;

      /// For Islamic style
      case AIStyle.islamic:

        /// Set the style string for Islamic style
        style = 'in arabic and muslims style,as muslim style, as arabic style';
        break;
    }

    /// Return the style string
    return style;
  }

  /// This [run] function runs the query with the chosen [AIStyle] and returns a map of the success status and the ID of the generated image.
  ///
  /// The [query] parameter is a string that contains the query for the AI service.
  ///
  /// The [style] parameter is an enum that represents the style of the generated image.
  ///
  /// The function returns a [Map<String, dynamic>] that contains the success status and the ID of the generated image.
  Future<Map<String, dynamic>> run(String query, AIStyle style) async {
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
        '''--$webKit\r\nContent-Disposition: form-data; name="queueType"\r\n\r\ngenerate\r\n--$webKit\r\nContent-Disposition: form-data; name="query"\r\n\r\n$query\r\n--$webKit\r\nContent-Disposition: form-data; name="preset"\r\n\r\n1\r\n--$webKit\r\nContent-Disposition: form-data; name="style"\r\n\r\n${getStyle(style)}\r\n--$webKit--''';

    /// This [response] variable is used to store the http response.
    var response = await client.post(apiUrl,
        headers: headers, body: requestData, encoding: utf8);

    /// Check the http status code of the response and return the appropriate response.
    if (response.statusCode == 201 || response.statusCode == 200) {
      /// Decode the body.
      final jsonResponse = json.decode(response.body);

      /// Get the success status.
      success = jsonResponse['success'] as bool;

      /// Get the PocketId
      pocketId = jsonResponse['result']['pocketId'] as String;

      ///return the map
      return {'success': success, 'id': pocketId};
    } else if (response.statusCode != 201 || response.statusCode != 200) {
      /// Throw an exception if the response status code is not 200 or 201
      throw Exception('run code : ${response.statusCode}');
    } else {
      /// Throw an exception if there was a failure to fetch the run
      throw Exception('Failed to make run');
    }
  }
}
