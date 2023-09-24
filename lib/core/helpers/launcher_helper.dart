// ignore_for_file: unnecessary_brace_in_string_interps, camel_case_types

import 'dart:io';

//import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LauncherHelper {
  static Future<void> sendSms(phone, message) async {
    final String uri = 'sms:${phone}?body=${message}';

    if (await canLaunchUrlString(uri)) {
      await launchUrlString(uri);
    }
  }

  static Future<void> sendMail(email, subject, body) async {
    final String uri = 'mailto:${email}?subject=${subject}&body=${body}';
    if (await canLaunchUrlString(uri)) {
      await launchUrlString(uri);
    }
  }

  static Future<void> goLocation(latitude, longitude) async {
    final String uri = 'geo:${latitude},${longitude}';

    if (await canLaunchUrlString(uri)) {
      await launchUrlString(uri);
    }
  }

  static Future<void> goUrl(url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
  }

  static Future<void> goFile(path) async {
    final Uri uri = Uri.file(path);

    if (!File(uri.toFilePath()).existsSync()) {
      if (await canLaunchUrlString(uri.toFilePath())) {
        await launchUrlString(uri.toFilePath());
      }
    }
  }

  static Future<void> goCall(phone) async {
    final String uri = 'tel:${phone}';

    if (await canLaunchUrlString(uri)) {
      await launchUrlString(uri);
    }
  }
}
