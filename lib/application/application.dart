import 'package:crypto_pulse/application/ui/Host.dart';
import 'package:crypto_pulse/di/di.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/model/_common/AppModel.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppModel>(
      create: (context) => getIt.get<AppModel>(),
      child: MaterialApp(
        title: 'Crypto Pulse',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x006974)),
          useMaterial3: true,
        ),
        home: const Host(),
      )
    );
  }
}