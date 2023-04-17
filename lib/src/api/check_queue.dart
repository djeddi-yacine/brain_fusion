import 'dart:convert';

import 'package:http/http.dart' as http;

import '../strings.dart';

/// The [CheckQueue] class is the First Checker
class CheckQueue {
  ///get Client form [AI]
  final http.Client client;
  CheckQueue({required this.client});

  ///the [checkQueue] function is first endpoint
  Future<bool> checkQueue() async {
    ///Create Uri apiUrl
    final Uri apiUrl = Uri.parse(checkQueueAPI);

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
      ///Decode the response
      final jsonResponse = json.decode(response.body);

      ///return the bool
      final success = jsonResponse['success'] as bool;

      ///return the bool
      return success;
    } else if (response.statusCode != 200) {
      throw Exception('check queue code :${response.statusCode}');
    } else {
      throw Exception('Failed to check queue');
    }
  }
}
