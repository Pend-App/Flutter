import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:pend_tech/component/style.dart';

class DemoTheme {
  final String name;
  final ThemeData data;

  const DemoTheme(this.name, this.data);
}

class ThemeBloc {
  final Stream<ThemeData> themeDataStream;
  final Sink<DemoTheme> selectedTheme;

  factory ThemeBloc() {
    final selectedTheme = PublishSubject<DemoTheme>();
    final themeDataStream = selectedTheme.distinct().map((theme) => theme.data);
    return ThemeBloc._(themeDataStream, selectedTheme);
  }

  const ThemeBloc._(this.themeDataStream, this.selectedTheme);

  DemoTheme initialTheme() {
    return DemoTheme(
        'initial',
        ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: colorStyle.primaryColor,
            backgroundColor: Colors.red,
            dividerColor: Colors.black87,
            accentColor: colorStyle.primaryColor,
            primaryColor: colorStyle.primaryColor,
            hintColor: Colors.red,
            buttonColor: colorStyle.primaryColor,
            canvasColor: Colors.amber,
            cardColor: Colors.grey,
            textSelectionColor: Colors.grey,
            textSelectionHandleColor: Colors.blue));
  }
}
