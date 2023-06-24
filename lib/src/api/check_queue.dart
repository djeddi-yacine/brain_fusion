/// Import the required libraries
import 'package:http/http.dart' as http;
import '../data/strings.dart';

/// The [CheckQueue] class is responsible for checking the queue before running the AI model
class CheckQueue {
  /// The [http.Client] instance for making HTTP requests
  final http.Client client;

  /// The constructor that takes a required [http.Client] instance
  CheckQueue({required this.client});

  /// The [checkQueue] function is the first endpoint
  ///
  /// It sends a GET request to the AI service to check if the queue is ready to accept requests
  ///
  /// It returns a [Future] that resolves to a [bool] value indicating whether the queue is ready or not
  Future<bool> checkQueue() async {
    ///Create the [Uri] object for the API endpoint
    final Uri apiUrl = Uri.parse(checkQueueAPI);

    ///Create a Map of headers for the GET request
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

    /// Send the GET request to the AI service
    final response = await client.head(apiUrl, headers: headers);

    if (response.statusCode == 200) {
      /// Return the boolean value indicating whether the queue is ready or not
      final bool success = true;

      return success;
    } else if (response.statusCode != 200) {
      /// Throw an exception if the GET request failed
      throw Exception('check queue code :${response.statusCode}');
    } else {
      throw Exception('Failed to check queue');
    }
  }
}
