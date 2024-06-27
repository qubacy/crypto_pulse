import 'dart:async';

import 'package:crypto_pulse/di/di.dart';
import 'package:flutter/material.dart';
import 'application/Application.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependecies();

  runApp(const Application());
}