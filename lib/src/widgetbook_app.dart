import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:wt_widgetbook/src/widgetbook_component_builder.dart';

class WidgetbookApp extends StatelessWidget {
  final Map<String, dynamic> builders;

  const WidgetbookApp({
    super.key,
    this.builders = const {},
  });

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'Light',
              data: ThemeData.light(),
            ),
            WidgetbookTheme(
              name: 'Dark',
              data: ThemeData.dark(),
            ),
          ],
        ),
        TextScaleAddon(
          scales: [1.0, 2.0, 4.0],
        ),
        DeviceFrameAddon(
          devices: [
            Devices.ios.iPhone12,
            Devices.ios.iPhone13Mini,
            Devices.ios.iPad,
            Devices.ios.iPhone12ProMax,
            Devices.macOS.macBookPro,
            Devices.macOS.wideMonitor,
          ],
        ),
      ],
      appBuilder: (context, child) => SafeArea(
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.zero,
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
        final builder = e.value as WidgetbookComponentBuilder;
        return WidgetbookCategory(
          name: e.key,
          children: [
            builder.build(),
          ],
        );
      } else if (e.value is List<WidgetbookComponentBuilder>) {
        final list = e.value as List<WidgetbookComponentBuilder>;
        return WidgetbookCategory(
          name: e.key,
          children: list.map((WidgetbookComponentBuilder builder) => builder.build()).toList(),
        );
      } else if (e.value is Map<String, dynamic>) {
        final map = e.value as Map<String, dynamic>;
        return WidgetbookCategory(name: e.key, children: createWidgetbookCategory(map));
      } else {
        return WidgetbookCategory(name: e.key, children: const []);
      }
    }).toList();
  }
}
