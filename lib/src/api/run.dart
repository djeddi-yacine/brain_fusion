import 'dart:convert';

import 'package:brain_fusion/brain_fusion.dart';
import 'package:http/http.dart' as http;

import '../strings.dart';

class Run {
  final String webKit;
  final http.Client client;

  Run({required this.client, required this.webKit});
  bool success = false;
  String pocketId = '';

  String getStyle(AIStyle aiStyle) {
    String style = '';
    switch (aiStyle) {
      case AIStyle.noStyle:
        style = '';
        break;
      case AIStyle.anime:
        style = 'in anime style';
        break;
      case AIStyle.moreDetails:
        style = '4k, ultra HD, detailed photo';
        break;
      case AIStyle.cyberPunk:
        style = 'in cyberpunk style, futuristic cyberpunk';
        break;
      case AIStyle.kandinskyPainter:
        style = 'painted by Vasily Kandinsky, abstractionis';
        break;
      case AIStyle.aivazovskyPainter:
        style = 'painted by Aivazovsky';
        break;
      case AIStyle.malevichPainter:
        style =
            'Malevich, suprematism, avant-garde art, 20th century, geometric shapes , colorful, Russian avant-garde';
        break;
      case AIStyle.picassoPainter:
        style = 'Cubist painting by Pablo Picasso, 1934, colourful';
        break;
      case AIStyle.goncharovaPainter:
        style =
            'painted by Goncharova, Russian avant-garde, futurism, cubism, suprematism';
        break;
      case AIStyle.classicism:
        style =
            'classicism painting, 17th century, trending on artstation, baroque painting';
        break;
      case AIStyle.renaissance:
        style = 'painting, renaissance old master royal collection, artstation';
        break;
      case AIStyle.oilPainting:
        style = 'like oil painting';
        break;
      case AIStyle.pencilDrawing:
        style = 'pencil art, pencil drawing, highly detailed';
        break;
      case AIStyle.digitalPainting:
        style =
            'high quality, highly detailed, concept art, digital painting, by greg rutkowski trending on artstation';
        break;
      case AIStyle.medievalStyle:
        style = 'medieval painting, 15th century, trending on artstation';
        break;
      case AIStyle.render3D:
        style =
            'Unreal Engine rendering, 3d render, photorealistic, digital concept art, octane render, 4k HD';
        break;
      case AIStyle.cartoon:
        style = 'as cartoon, picture from cartoon';
        break;
      case AIStyle.studioPhoto:
        style =
            'glamorous, emotional ,shot in the photo studio, professional studio lighting, backlit, rim lighting, 8k';
        break;
      case AIStyle.portraitPhoto:
        style = '50mm portrait photography, hard rim lighting photography';
        break;
      case AIStyle.mosaic:
        style = 'as tile mosaic';
        break;
      case AIStyle.iconography:
        style =
            'in the style of a wooden christian medieval icon in the church';
        break;
      case AIStyle.khokhlomaPainter:
        style =
            'in Russian style, Khokhloma, 16th century, marble, decorative, realistic';
        break;
      case AIStyle.christmas:
        style =
            'christmas, winter, x-mas, decorations, new year eve, snowflakes, 4k';
        break;
      case AIStyle.islamic:
        style = 'in arabic and muslims style,as muslim style, as arabic style';
        break;
    }
    return style;
  }

  Future<Map<String, dynamic>> run(String query, AIStyle style) async {
    final url = Uri.parse(runAPI);

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

    final requestData =
        '''--$webKit\r\nContent-Disposition: form-data; name="queueType"\r\n\r\ngenerate\r\n--$webKit\r\nContent-Disposition: form-data; name="query"\r\n\r\n$query\r\n--$webKit\r\nContent-Disposition: form-data; name="preset"\r\n\r\n1\r\n--$webKit\r\nContent-Disposition: form-data; name="style"\r\n\r\n${getStyle(style)}\r\n--$webKit--''';

    var response = await client.post(url,
        headers: headers, body: requestData, encoding: utf8);
    if (response.statusCode == 201 || response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      success = jsonResponse['success'] as bool;
      pocketId = jsonResponse['result']['pocketId'] as String;
      return {'success': success, 'id': pocketId};
    } else if (response.statusCode != 201 || response.statusCode != 200) {
      throw Exception('run code : ${response.statusCode}');
    } else {
      throw Exception('Failed to make run');
    }
  }
}
