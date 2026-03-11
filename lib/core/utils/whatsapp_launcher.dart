/// core/utils/whatsapp_launcher.dart

import 'package:url_launcher/url_launcher.dart';

class WhatsAppLauncher {
  /// Open WhatsApp bot
  ///
  /// Example usage:
  /// WhatsAppLauncher.openTallyBot(phoneNumber: "263771234567")
  static Future<void> openTallyBot({
    required String phoneNumber,
    String? message,
  }) async {
    final encodedMessage =
        Uri.encodeComponent(message ?? "Hello Tally Up");

    final url = Uri.parse(
      "https://wa.me/$phoneNumber?text=$encodedMessage",
    );

    final canLaunch = await canLaunchUrl(url);

    if (!canLaunch) {
      throw Exception("WhatsApp is not available on this device");
    }

    final launched = await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );

    if (!launched) {
      throw Exception("Failed to open WhatsApp");
    }
  }
}