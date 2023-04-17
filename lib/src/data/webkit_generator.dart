import 'dart:math';

///[WebKit] class is for Generate new webkit token
///with help of dart:math
class WebKit {
  /// Generate a random string of specified length
  String _generateRandomString(int length) {
    ///Create variable
    var random = Random();

    ///Create variable
    var codeUnits = List.generate(length, (index) => random.nextInt(26) + 97);

    /// ASCII lowercase letters
    /// return new code
    return String.fromCharCodes(codeUnits);
  }

  /// Generate a boundary string for multipart/form-data request
  String generateBoundaryString() {
    ///Create variable
    var timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    ///Create variable
    var randomString = _generateRandomString(16);

    ///return the new webkit
    return '----$timestamp$randomString----';
  }
}
