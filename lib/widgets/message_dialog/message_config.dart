import 'package:flutter/material.dart';

enum MessState { error, success, customIcon }

class MessageConfig {
  static BuildContext? contextConfig;

  static void init(BuildContext context) {
    if (contextConfig != null) {
      return;
    }
    contextConfig = context;
  }
}
