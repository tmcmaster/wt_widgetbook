import 'package:flutter/material.dart';
import 'package:ipsum/ipsum.dart';
import 'package:widgetbook/widgetbook.dart';

class VariableTextBuilder extends StatelessWidget {
  final Widget Function(BuildContext, String text) itemBuilder;

  static final ipsum = Ipsum();

  const VariableTextBuilder({
    super.key,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final words = context.knobs.double
        .slider(
          label: 'Number of Words',
          initialValue: 4,
        )
        .toInt();
    final text = ipsum.words(words);
    return itemBuilder(context, text);
  }
}
