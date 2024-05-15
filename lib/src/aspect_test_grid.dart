import 'package:flutter/material.dart';

class AspectTestGrid extends StatelessWidget {
  final List<double> testAspects;
  // final double percentage;

  final Widget Function(BuildContext context, double aspect) itemBuilder;

  const AspectTestGrid({
    super.key,
    this.testAspects = const [
      0.25,
      0.5,
      0.75,
      1,
      1.25,
      1.5,
      1.75,
      2,
    ],
    required this.itemBuilder,
    // this.percentage = 100,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final orientation = constraints.maxWidth > constraints.maxHeight
            ? Orientation.landscape
            : Orientation.portrait;

        return GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: orientation == Orientation.landscape ? 4 : 2,
          children: testAspects
              .map(
                (aspect) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: aspect,
                      child: itemBuilder(context, aspect),
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
