import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/enums.dart';
import '../data/strings.dart';

///the [Run] class is for Start the Generation Process
class Run {
  ///get String of [webKit]
  final String webKit;

  ///get Client form [AI]
  final http.Client client;

  Run({required this.client, required this.webKit});

  ///Create bool [success] to check
  bool success = false;

  ///Create String [pocketId] to get the id
  String pocketId = '';

  ///Create [getStyle] function to pass the style
  String getStyle(AIStyle aiStyle) {
    ///Create empty String
    String style = '';

    ///make switch Statement
    switch (aiStyle) {
      ///if
      case AIStyle.noStyle:

        ///return
        style = '';
        break;

      ///if
      case AIStyle.anime:

        ///return
        style = 'in anime style';
        break;

      ///if
      case AIStyle.moreDetails:

        ///return
        style = '4k, ultra HD, detailed photo';
        break;

      ///if
      case AIStyle.cyberPunk:

        ///return
        style = 'in cyberpunk style, futuristic cyberpunk';
        break;

      ///if
      case AIStyle.kandinskyPainter:

        ///return
        style = 'painted by Vasily Kandinsky, abstractionis';
        break;

      ///if
      case AIStyle.aivazovskyPainter:

        ///return
        style = 'painted by Aivazovsky';
        break;

      ///if
      case AIStyle.malevichPainter:

        ///return
        style =
            'Malevich, suprematism, avant-garde art, 20th century, geometric shapes , colorful, Russian avant-garde';
        break;

      ///if
      case AIStyle.picassoPainter:

        ///return
        style = 'Cubist painting by Pablo Picasso, 1934, colourful';
        break;

      ///if
      case AIStyle.goncharovaPainter:

        ///return
        style =
            'painted by Goncharova, Russian avant-garde, futurism, cubism, suprematism';
        break;

      ///if
      case AIStyle.classicism:

        ///return
        style =
            'classicism painting, 17th century, trending on artstation, baroque painting';
        break;

      ///if
      case AIStyle.renaissance:

        ///return
        style = 'painting, renaissance old master royal collection, artstation';
        break;

      ///if
      case AIStyle.oilPainting:

        ///return
        style = 'like oil painting';
        break;

      ///if
      case AIStyle.pencilDrawing:

        ///return
        style = 'pencil art, pencil drawing, highly detailed';
        break;

      ///if
      case AIStyle.digitalPainting:

        ///return
        style =
            'high quality, highly detailed, concept art, digital painting, by greg rutkowski trending on artstation';
        break;

      ///if
      case AIStyle.medievalStyle:

        ///return
        style = 'medieval painting, 15th century, trending on artstation';
        break;

      ///if
      case AIStyle.render3D:

        ///return
        style =
            'Unreal Engine rendering, 3d render, photorealistic, digital concept art, octane render, 4k HD';
        break;

      ///if
      case AIStyle.cartoon:

        ///return
        style = 'as cartoon, picture from cartoon';
        break;

      ///if
      case AIStyle.studioPhoto:

        ///return
        style =
            'glamorous, emotional ,shot in the photo studio, professional studio lighting, backlit, rim lighting, 8k';
        break;

      ///if
      case AIStyle.portraitPhoto:

        ///return
        style = '50mm portrait photography, hard rim lighting photography';
        break;

      ///if
      case AIStyle.mosaic:

        ///return
        style = 'as tile mosaic';
        break;

      ///if
      case AIStyle.iconography:

        ///return
        style =
            'in the style of a wooden christian medieval icon in the church';
        break;

      ///if
      case AIStyle.khokhlomaPainter:

        ///return
        style =
            'in Russian style, Khokhloma, 16th century, marble, decorative, realistic';
        break;

      ///if
      case AIStyle.christmas:

        ///return
        style =
            'christmas, winter, x-mas, decorations, new year eve, snowflakes, 4k';
        break;

      ///if
      case AIStyle.islamic:

        ///return
        style = 'in arabic and muslims style,as muslim style, as arabic style';
        break;
    }

    ///return
    return style;
  }

  ///Thi [run] function to run the query with the choose style [AIStyle]
  Future<Map<String, dynamic>> run(String query, AIStyle style) async {
    ///New Uri apiUrl
    final Uri apiUrl = Uri.parse(runAPI);

    ///Create Map of headers
    final headers = {
      'Accept': 'application/json, text/plain, */*',
      'Accept-Language': 'en-US,en;q=0.9,en-GB;q=0.8',
      'Cache-Control': 'no-cache',
      'Connection': 'keep-alive',
      'Content-Type': 'multipart/form-data; boundary=$webKit',
      'DNT': '1',
      'Origin': origin,
      'Pragma': 'no-cache',
      'Referer': referer,
      'Sec-Fetch-Dest': 'empty',
      'Sec-Fetch-Mode': 'cors',
      'Sec-Fetch-Site': 'same-origin',
      'User-Agent': userAgent,
      'sec-ch-ua': secChUa,
    };

    ///The Data of the Request
    final requestData =
        '''--$webKit\r\nContent-Disposition: form-data; name="queueType"\r\n\r\ngenerate\r\n--$webKit\r\nContent-Disposition: form-data; name="query"\r\n\r\n$query\r\n--$webKit\r\nContent-Disposition: form-data; name="preset"\r\n\r\n1\r\n--$webKit\r\nContent-Disposition: form-data; name="style"\r\n\r\n${getStyle(style)}\r\n--$webKit--''';

    ///await for Response
    var response = await client.post(apiUrl,
        headers: headers, body: requestData, encoding: utf8);
    if (response.statusCode == 201 || response.statusCode == 200) {
      ///Decode the body
      final jsonResponse = json.decode(response.body);

      ///get the bool
      success = jsonResponse['success'] as bool;

      ///get the id
      pocketId = jsonResponse['result']['pocketId'] as String;

      ///return the map
      return {'success': success, 'id': pocketId};
    } else if (response.statusCode != 201 || response.statusCode != 200) {
      throw Exception('run code : ${response.statusCode}');
    } else {
      throw Exception('Failed to make run');
    }
  }
}
