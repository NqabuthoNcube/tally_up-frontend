import 'package:url_launcher/url_launcher.dart';

class WhatsAppLauncher {
  static Future<void> openTallyBot({
    required String phoneNumber,
    String? message,
  }) async {
    final encodedMessage =
        Uri.encodeComponent(message ?? "Hello Tally Up");

    final url = Uri.parse(
      "https://wa.me/$phoneNumber?text=$encodedMessage",
    );

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception("Could not open WhatsApp");
    }
  }
}