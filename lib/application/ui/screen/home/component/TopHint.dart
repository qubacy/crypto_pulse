import 'package:flutter/material.dart';

class TopHint extends StatelessWidget {
  final String hint;
  final EdgeInsets margin;

  TopHint({super.key, required this.hint, this.margin = const EdgeInsets.all(8.0)});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge;

    return Container(
      alignment: Alignment.centerLeft,
      padding: margin,
      child: Text(hint, style: textStyle,)
    );
  }
}