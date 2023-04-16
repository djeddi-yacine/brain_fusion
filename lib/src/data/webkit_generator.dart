import 'dart:math';

class WebKit {
  // Generate a random string of specified length
  String generateRandomString(int length) {
    var random = Random();
    var codeUnits = List.generate(
        length, (index) => random.nextInt(26) + 97); // ASCII lowercase letters
    return String.fromCharCodes(codeUnits);
  }

// Generate a boundary string for multipart/form-data request
  String generateBoundaryString() {
    var timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    var randomString = generateRandomString(16);
    return '----$timestamp$randomString----';
  }
}
