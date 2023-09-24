import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MessageWidget extends StatelessWidget {
  final String message;
  const MessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: Center(
          child: Text(message),
        ));
  }
}
