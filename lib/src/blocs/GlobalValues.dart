import 'dart:async';

import 'package:flutter/material.dart';

class GlobalValues extends InheritedWidget {
  StreamController controller;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  GlobalValues({Key key, Widget child}) : super(key: key, child: child);

  static GlobalValues of(BuildContext context) {
    //return context.dependOnInheritedWidgetOfExactType(aspect: GlobalValues) as GlobalValues;
    return context.inheritFromWidgetOfExactType(GlobalValues) as GlobalValues;
  }
}
