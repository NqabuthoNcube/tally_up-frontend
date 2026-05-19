/// core/services/whatsapp_service.dart
library;

import 'package:url_launcher/url_launcher.dart';

class WhatsAppService {
  /// Opens WhatsApp chat with optional message
  static Future<void> openChat({
    required String phoneNumber,
    String? message,
  }) async {
    final encodedMessage =
        message != null ? Uri.encodeComponent(message) : "";

    final url = Uri.parse(
      "https://wa.me/$phoneNumber?text=$encodedMessage",
    );

    if (!await canLaunchUrl(url)) {
      throw Exception("Could not launch WhatsApp");
    }

    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }
}