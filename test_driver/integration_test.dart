import 'dart:io';
import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  try {
    await integrationDriver(
      onScreenshot:
          (
            String screenshotName,
            List<int> screenshotBytes, [
            Map<String, Object?>? args,
          ]) async {
            final File image = File('screenshots/$screenshotName.png');
            // Ensure directory exists
            image.parent.createSync(recursive: true);
            image.writeAsBytesSync(screenshotBytes);
            // Return true to indicate the screenshot was saved successfully
            return true;
          },
    );
  } catch (e) {
    print('Error occurred during integration tests: $e');
  }
}
