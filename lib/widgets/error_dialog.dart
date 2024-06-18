// Error widget

import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onOkPressed;

  const ErrorDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.onOkPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onOkPressed,
          child: Text('OK'),
        ),
      ],
    );
  }
}