import 'package:flutter/material.dart';
import 'package:pend_tech/component/style.dart';

SnackBar alertSnackBar(BuildContext context,String message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  return SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
      backgroundColor: colorStyle.accentColor,
      content: Text(
        message,
        style: const TextStyle(fontSize: 17),
      ));
}