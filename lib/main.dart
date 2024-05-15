import 'package:flutter/material.dart';
import 'package:ipsum/ipsum.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(HotReloadWidgetBook(
    builders: {
      'Applications': [
        WidgetbookPackage(name: 'My Package', children: [
          WidgetbookComponent(name: 'My Component', useCases: []),
        ]),
        WidgetbookPackage(name: 'My Package', children: []),
      ],
      'Widgets': {
        'Buttons': [
          AspectRatioTextSizeBuilder(
            title: 'TextButton',
            builder: (_, text) => TextButton(
              onPressed: () {},
              child: Text(text),
            ),
          ),
          AspectRatioTextSizeBuilder(
            title: 'ElevatedButton',
            builder: (_, text) => ElevatedButton(
              onPressed: () {},
              child: Text(text),
            ),
          ),
          AspectRatioTextSizeBuilder(
            title: 'IconButton',
            builder: (_, text) => IconButton(
              onPressed: () {},
              color: Colors.blueAccent,
              icon: const Icon(Icons.add),
            ),
          ),
          AspectRatioTextSizeBuilder(
            title: 'FloatingActionButton',
            builder: (_, text) => FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.blueAccent,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      }
    },
  ));
}

class HotReloadWidgetBook extends StatelessWidget {
  final Map<String, dynamic> builders;

  const HotReloadWidgetBook({
    super.key,
    this.builders = const {},
  });

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [
        MaterialThemeAddon(themes: [
          WidgetbookTheme(
            name: 'Light',
            data: ThemeData.light(),
          ),
          WidgetbookTheme(
            name: 'Dark',
            data: ThemeData.dark(),
          ),
        ]),
        TextScaleAddon(
          scales: [1.0, 2.0, 4.0],
        ),
        DeviceFrameAddon(devices: [
          Devices.ios.iPhone12,
          Devices.ios.iPhone13Mini,
          Devices.ios.iPad,
          Devices.ios.iPhone12ProMax,
          Devices.macOS.macBookPro,
          Devices.macOS.wideMonitor,
        ]),
      ],
      appBuilder: (context, child) => SafeArea(
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.all(0.0),
            child: Center(
              child: child,
            ),
          ),
        ),
      ),
      directories: createWidgetbookCategory(builders),
    );
  }

  List<WidgetbookCategory> createWidgetbookCategory(Map<String, dynamic> builders) {
    return builders.entries.map((e) {
      if (e.value is WidgetbookComponentBuilder) {
        return WidgetbookCategory(name: e.key, children: [
          e.value.build(),
        ]);
      } else if (e.value is List<WidgetbookComponentBuilder>) {
        List<WidgetbookComponentBuilder> list = e.value;
        return WidgetbookCategory(
          name: e.key,
          children: list.map((WidgetbookComponentBuilder builder) => builder.build()).toList(),
        );
      } else if (e.value is Map<String, dynamic>) {
        return WidgetbookCategory(name: e.key, children: createWidgetbookCategory(e.value));
      } else {
        return WidgetbookCategory(name: e.key, children: const []);
      }
    }).toList();
  }
}

mixin WidgetbookComponentBuilder {
  WidgetbookComponent build();
}

class AspectRatioTextSizeBuilder with WidgetbookComponentBuilder {
  final String title;
  final Widget Function(BuildContext, String text) builder;
  AspectRatioTextSizeBuilder({
    required this.title,
    required this.builder,
  });

  @override
  WidgetbookComponent build() {
    return WidgetbookComponent(
      name: title,
      useCases: [
        WidgetbookUseCase(
          name: 'Aspects Ratios',
          builder: (context) => AspectTestGrid(
            itemBuilder: (context, aspect) => VariableSizeBuilder(
              child: VariableTextBuilder(
                itemBuilder: builder,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AspectRatioTextSizeTests extends StatelessWidget {
  final String title;
  final Widget Function(BuildContext, String text) builder;

  const AspectRatioTextSizeTests({
    super.key,
    required this.title,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class GridWidgetTester extends StatelessWidget {
  static const testText = [
    'a',
    'aa',
    'aa aa',
    'one two three',
  ];

  const GridWidgetTester({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: mediaQuery.orientation == Orientation.landscape ? 2 : 4,
      children: testText
          .map(
            (text) => Center(
              child: AspectRatio(
                aspectRatio: context.knobs.double.slider(
                  label: 'Aspect Ratio',
                  initialValue: 1.0,
                  min: 0.1,
                  max: 2.0,
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(text),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class AspectWordsTestGrid extends StatelessWidget {
  final int words;

  const AspectWordsTestGrid({
    super.key,
    this.words = 4,
  });

  @override
  Widget build(BuildContext context) {
    final ipsum = Ipsum();

    final text = ipsum.words(words.toInt());

    return AspectTestGrid(
      itemBuilder: (_, __) => ElevatedButton(
        onPressed: () {},
        child: Text(text),
      ),
    );
  }
}

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

    return LayoutBuilder(builder: (_, constraints) {
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
    });
  }
}

class AspectTestGrid extends StatelessWidget {
  final List<double> testAspects;
  // final double percentage;

  final Widget Function(BuildContext context, double aspect) itemBuilder;

  const AspectTestGrid({
    Key? key,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
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
    });
  }
}
