# wt_widgetbook

This is a component for enabling Widgetbook to be defined as a bested map, 
and also supplies builders for creating sets of usecases with preconfigured
Widgetbook knobs.

## An example of configuring

```dart
WidgetbookApp(
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
```
