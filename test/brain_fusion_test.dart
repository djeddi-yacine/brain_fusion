import 'package:brain_fusion/brain_fusion.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('generate image', () async {
    // Create an instance of the AI class
    AI ai = AI();
    // Call the runAI method with the required parameters
    String query = 'sukuna from jujutsu kaisen';
    try {
      Uint8List image = await ai.runAI(query, AIStyle.anime);
      // Use the returned image data as needed
      if (kDebugMode) {
        print(image);
      }
    } catch (e) {
      // Handle any exceptions that may occur during AI processing
      if (kDebugMode) {
        print('Error from AI package: $e');
      }
    }
  });
}
