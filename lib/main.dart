import 'package:core_news/pages/app_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/widgets/device_preview_widget.dart';
import '../injection/injetion_container.dart' as DI;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DI.init();
  var sharedPreferences = await SharedPreferences.getInstance();

  runApp(devicePreviewWidget(AppPage(sharedPreferences: sharedPreferences)));
}
