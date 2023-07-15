/// Importing the required libraries.
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/strings.dart';

/// The [Status] class is responsible for checking the status of the query.
class Status {
  /// The [client] property holds the instance of [http.Client] class for making HTTP requests.
  final http.Client client;

  /// Creates an instance of the [Status] class with the [client] property as a required parameter.
  Status({required this.client});

  /// The [getStatus] function is used to send a request to the API to check the status of the query with the given [id].
  /// Returns a [Map] value indicating whether the status check was successful or not.
  Future<Map<String, dynamic>> getStatus(String uuid) async {
    if (uuid == '') {
      /// If the [uuid] is empty, an exception is thrown with an appropriate error message.
      throw Exception('there is no uuid');
    }

    /// The [apiUrl] variable holds the Uri to be used for the status request.
    final Uri apiUrl = Uri.parse('$status/$uuid');

    /// The [headers] variable is a map holding the required headers for the request.
    final headers = {
      'Accept': '*/*',
      'Accept-Language': 'en-US,en;q=0.9,en-GB;q=0.8',
      'Cache-Control': 'no-cache',
      'Connection': 'keep-alive',
      'Pragma': 'no-cache',
      'Referer': referer,
      'Sec-Fetch-Site': 'same-origin',
      'User-Agent': userAgent,
      'sec-ch-ua': secChUa,
    };

    /// The [response] variable holds the response received from the API after sending the status request.
    final response = await client.get(apiUrl, headers: headers);

    if (response.statusCode == 200) {
      /// If the response status code is 200, the [jsonResponse] variable is used to hold the decoded response body.

      final jsonResponse = jsonDecode(response.body);

      /// The [status] property is updated with the value of the 'status' key from the [jsonResponse].
      final String? status = jsonResponse['status'] as String?;

      /// The [image] property is updated with the value of the 'image' key from the [jsonResponse].
      final List<dynamic>? image = jsonResponse['images'] as List<dynamic>?;

      /// The [error] property is updated with the value of the 'error' key from the [jsonResponse].
      final String? error = jsonResponse['errorDescription'] as String?;

      /// Return the data.
      return {"status": status, "image": image, "error": error};
    } else if (response.statusCode != 200) {
      /// If the response status code is not 200, an exception is thrown with an appropriate error message.
      throw Exception('status code : ${response.statusCode}');
    } else {
      /// If the status request failed, an exception is thrown with an appropriate error message.
      throw Exception('Failed to fetch status');
    }
  }
}
