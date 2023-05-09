import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnakBar(
    BuildContext context,
    {required String title,
    required Color bgColor}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: bgColor,
    content: Text(title),
  ));
}