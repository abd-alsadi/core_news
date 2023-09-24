// ignore_for_file: camel_case_types

import 'package:core_news/configs/resources/app_colors.dart';
import 'package:core_news/configs/resources/app_strings.dart';
import 'package:core_news/core/utils/app_localizations.dart';
import 'package:flutter/material.dart';

class PopupHelper {
  static void showSnackbarMessage(context, message, duration) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(duration: duration, content: Text(message)));
  }

  static void showDialogMessage(context, message, cancelCallback, okCallback) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title:
                Text(appLocalizations.trans(context, appStrings.APP_NAME_KEY)),
            content: Text(appLocalizations.trans(context, message)),
            actionsAlignment: MainAxisAlignment.start,
            actionsPadding: const EdgeInsets.all(2),
            scrollable: false,
            actions: [
              TextButton(
                  onPressed: () {
                    okCallback();
                  },
                  child:
                      Text(appLocalizations.trans(context, appStrings.OK_KEY))),
              TextButton(
                  onPressed: () {
                    cancelCallback();
                  },
                  child: Text(
                      appLocalizations.trans(context, appStrings.CANCEL_KEY)))
            ],
          );
        });
  }

  static void showTopDialogMessage(context, message, actions) {
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
        leading: const Icon(Icons.notifications_active_outlined),
        content: Text(message),
        actions: actions));
  }

  static void showBottomDialogMessage(context, content, double height) {
    showModalBottomSheet(
        backgroundColor: appColors.white,
        isDismissible: true,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(10),
            color: Colors.transparent,
            child: content,
            height: height,
          );
        });
  }
}
