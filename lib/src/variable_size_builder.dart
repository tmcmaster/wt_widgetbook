import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class VariableSizeBuilder extends StatelessWidget {
  final Widget child;

  const VariableSizeBuilder({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final paddingPercentage = 1 -
        (context.knobs.double.slider(
              label: 'Size Percentage',
              initialValue: 100,
              min: 0,
              max: 100,
            ) /
            100);

    return LayoutBuilder(
      builder: (_, constraints) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: constraints.maxWidth / 2 * paddingPercentage,
            vertical: constraints.maxHeight / 2 * paddingPercentage,
          ),
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
            child: child,
          ),
        );
      },
    );
  }
}
