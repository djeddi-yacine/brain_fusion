/// Importing required libraries
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../data/strings.dart';

/// The [Entities] class is responsible for returning the PNG code
class Entities {
  /// HTTP client for making requests
  final http.Client client;

  /// Constructor for the [Entities] class
  Entities({required this.client});

  /// The [getEntities] function is used to get the [Uint8List] of the PNG
  /// [id] - the ID of the PNG to get
  Future<Uint8List> getEntities(String id) async {
    /// Create the URL for the API endpoint
    final Uri apiUrl = Uri.parse('$pocketsAPI/$id/entities');

    /// Create the headers for the HTTP request
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

    /// Make the HTTP request to the API
    final response = await client.get(apiUrl, headers: headers);

    /// Check the response status code
    if (response.statusCode == 200) {
      /// Decode the response body from JSON
      final jsonResponse = jsonDecode(response.body);

      /// Get the PNG data from the response
      final png = jsonResponse['result'][0]['response'][0];

      /// Decode the PNG code into bytes
      final bytes = base64.decode("$png");

      /// Return the bytes of the PNG
      return bytes;
    } else if (response.statusCode != 200) {
      /// Throw an exception if the response status code is not 200
      throw Exception('entities code: ${response.statusCode}');
    } else {
      /// Throw an exception if there was a failure to fetch the status
      throw Exception('Failed to fetch status');
    }
  }
}
