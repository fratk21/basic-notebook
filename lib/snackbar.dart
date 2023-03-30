import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

showSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: text,
      message: '',

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType:
          text == "success" ? ContentType.success : ContentType.failure,
    ),
  );

  return ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
