import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:wt_widgetbook/wt_widgetbook.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetbookApp(
      builders: {
        'Applications': const [
          WidgetbookPackage(
            name: 'My Package',
            children: [
              WidgetbookComponent(name: 'My Component', useCases: []),
            ],
          ),
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
    );
  }
}
