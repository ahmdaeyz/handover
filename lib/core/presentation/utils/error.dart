import 'package:flutter/material.dart';

void showErrorMessage(
    {required BuildContext context, required String message}) {
  final messenger = ScaffoldMessenger.maybeOf(context);
  final snackBar = SnackBar(
      content: Text(
    message,
    style:
        Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white),
  ));
  messenger?.showSnackBar(snackBar);
}
