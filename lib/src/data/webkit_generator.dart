import 'dart:math';

/// A class for generating new WebKit tokens.
class WebKit {
  /// Generates a random string of the specified [length].
  ///
  /// This method uses the `dart:math` library to generate a list of code units
  /// representing ASCII lowercase letters. It then converts this list to a
  /// string and returns the result.
  ///
  /// Throws an [ArgumentError] if [length] is less than or equal to zero.
  String _generateRandomString(int length) {
    if (length <= 0) {
      throw ArgumentError('Length must be greater than zero');
    }

    var random = Random();
    var codeUnits = List.generate(length, (index) => random.nextInt(26) + 97);
    return String.fromCharCodes(codeUnits);
  }

  /// Generates a boundary string for a multipart/form-data request.
  ///
  /// The boundary string is used to separate different parts of a
  /// multipart/form-data request. It consists of a timestamp and a randomly
  /// generated string.
  ///
  /// Returns a string in the format `"----timestamprandomString----"`.
  String generateBoundaryString() {
    var timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    var randomString = _generateRandomString(16);
    return '----$timestamp$randomString----';
  }
}
