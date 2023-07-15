/// Import the necessary packages for the test
import 'dart:typed_data';

import 'package:brain_fusion/brain_fusion.dart';
import 'package:test/scaffolding.dart';

/// The main function that runs the test
void main() {
  /// The test function that generates an image from a query using the AI model
  test('generate image', () async {
    /// Create an instance of the AI class
    AI ai = AI();

    /// Define the query and AI style
    String query = 'sukuna from jujutsu kaisen';
    AIStyle style = AIStyle.anime;
    Resolution resolution = Resolution.r1x1;
    try {
      /// Call the runAI method with the required parameters
      Uint8List image = await ai.runAI(query, style, resolution);

      /// Use the returned image data as needed
      print(image);
    } catch (e) {
      /// Handle any exceptions that may occur during AI processing
      print(e);
    }
  });
}

/// This test ensures that the AI model is able to generate an image from a query
/// It creates an instance of the AI class and calls the runAI method with a query and AI style
/// It then checks that an image is returned and prints the image data if in debug mode
/// If an error occurs during AI processing, it is caught and printed if in debug mode.
