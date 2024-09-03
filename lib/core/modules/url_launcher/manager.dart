import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../setup.dart';

class UrlLauncherManager {
  static UrlLauncherManager? _instance;
  static UrlLauncherManager get instance {
    _instance ??= UrlLauncherManager._init();
    return _instance!;
  }

  UrlLauncherManager._init();

  Future<void> launch(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      Logger().e('Could not launch $url');
    }
  }

  Future<void> launchAppUrl() async {
    String url = 'https://${ApplicationSetup.instance.appMode.url}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      Logger().e('Could not launch $url');
    }
  }

  Future<void> launchCustomUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      Logger().e('Could not launch $url');
    }
  }

  Future<void> sendMail() async {
    String mail = "info@codeadijital.com";
    final Uri emailLaunchUri = Uri(scheme: 'mailto', path: mail, query: 'subject=Feedback');
    try {
      await launchUrl(emailLaunchUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      Logger().e(e);
    }
  }
}
