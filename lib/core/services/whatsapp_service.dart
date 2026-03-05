import 'package:url_launcher/url_launcher.dart';

class WhatsAppService {

  static openBot() async {

    final url = Uri.parse(
      "https://wa.me/263771234567"
    );

    if(await canLaunchUrl(url)){
      launchUrl(url);
    }
  }
}