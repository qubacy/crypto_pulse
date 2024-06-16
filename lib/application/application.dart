import 'package:crypto_pulse/application/ui/host.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Pulse',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0x006974)),
        useMaterial3: true,
      ),
      home: const Host(),
    );
  }
}