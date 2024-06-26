import 'dart:async';

import 'package:crypto_pulse/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'application/Application.dart';

Future main() async {
  await DotEnv().load();

  configureDependecies();
  runApp(const Application());
}