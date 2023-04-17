import 'dart:convert';

import 'package:http/http.dart' as http;

import '../strings.dart';

///the [Status] class is for Check the Status of the Query
class Status {
  ///get Client form [AI]
  final http.Client client;
  Status({required this.client});

  ///Create bool [success] to check
  bool success = false;

  ///Create String [result] to Verify
  String result = '';

  ///Create [getStatus] function to make the [request]
  Future<bool> getStatus(String id) async {
    ///Create Uri apiUrl
    final Uri apiUrl = Uri.parse('$pocketsAPI/$id/status');

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

    /// Get the Response
    final response = await client.get(apiUrl, headers: headers);

    if (response.statusCode == 200) {
      ///Decode the
      final jsonResponse = jsonDecode(response.body);

      ///get the success
      success = jsonResponse['success'] as bool;

      ///return the result
      result = jsonResponse['result'] as String;

      ///return the success
      return success;
    } else if (response.statusCode != 200) {
      throw Exception('status code : ${response.statusCode}');
    } else {
      throw Exception('Failed to fetch status');
    }
  }
}
