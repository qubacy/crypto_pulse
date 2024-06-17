import 'package:flutter/material.dart';

class TopHint extends StatelessWidget {
  final String hint;

  TopHint({super.key, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(hint)
      );
  }
}