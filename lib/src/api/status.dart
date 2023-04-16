import 'dart:convert';

import 'package:http/http.dart' as http;

import '../strings.dart';

class Status {
  final http.Client client;
  Status({required this.client});
  bool success = false;
  String result = '';
  Future<bool> getStatus(String id) async {
    final Uri apiUrl = Uri.parse('$pocketsAPI/$id/status');
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
      'User-Agent':
          'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36',
      'sec-ch-ua':
          '"Google Chrome";v="111", "Not(A:Brand";v="8", "Chromium";v="111"',
    };
    final response = await client.get(apiUrl, headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      success = jsonResponse['success'] as bool;
      result = jsonResponse['result'] as String;
      return success;
    } else if (response.statusCode != 200) {
      throw Exception('status code : ${response.statusCode}');
    } else {
      throw Exception('Failed to fetch status');
    }
  }
}
