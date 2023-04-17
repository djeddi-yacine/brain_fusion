import 'dart:convert';

import 'package:http/http.dart' as http;

import '../strings.dart';

class CheckQueue {
  final http.Client client;
  CheckQueue({required this.client});

  Future<bool> checkQueue() async {
    final url = Uri.parse(checkQueueAPI);
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
    final response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final success = jsonResponse['success'] as bool;
      return success;
    } else if (response.statusCode != 200) {
      throw Exception('check queue code :${response.statusCode}');
    } else {
      throw Exception('Failed to check queue');
    }
  }
}
