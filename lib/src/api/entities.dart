import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../strings.dart';

///The [Entities] class for return the Png Code
class Entities {
  ///get Client form [AI]
  final http.Client client;
  Entities({required this.client});

  ///the [getEntities] unction to return the [Uint8List] of the png
  Future<Uint8List> getEntities(String id) async {
    ///Create Uri apiUrl
    final Uri apiUrl = Uri.parse('$pocketsAPI/$id/entities');

    ///Create Map of headers
    final headers = {
      'Accept': 'application/json, text/plain, */*',
      'Accept-Language': 'en-US,en;q=0.9,en-GB;q=0.8',
      'Cache-Control': 'no-cache',
      'Connection': 'keep-alive',
      'DNT': '1',
      'Pragma': 'no-cache',
      'Referer': referer,
      'Sec-Fetch-Dest': 'empty',
      'Sec-Fetch-Mode': 'cors',
      'Sec-Fetch-Site': 'same-origin',
      'User-Agent': userAgent,
      'sec-ch-ua': secChUa,
    };

    ///await the response
    final response = await client.get(apiUrl, headers: headers);
    if (response.statusCode == 200) {
      ///Decode the body
      final jsonResponse = jsonDecode(response.body);

      ///get the data
      final png = jsonResponse['result'][0]['response'][0];

      ///decode the code
      final bytes = base64.decode("$png");

      ///return the bytes
      return bytes;
    } else if (response.statusCode != 200) {
      throw Exception('entities code : ${response.statusCode}');
    } else {
      throw Exception('Failed to fetch status');
    }
  }
}
