import 'package:url_launcher/url_launcher.dart';

void openWhatsapp(String phone) async {
  var whatsappUrl = "whatsapp://send?phone=$phone";

  if (await canLaunch(whatsappUrl)) await launch(whatsappUrl);
}
