import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'application/Application.dart';

Future main() async {
  await DotEnv().load();

  runApp(const Application());
}