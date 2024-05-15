import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:wt_widgetbook/src/aspect_test_grid.dart';
import 'package:wt_widgetbook/src/variable_size_builder.dart';
import 'package:wt_widgetbook/src/variable_text_builder.dart';
import 'package:wt_widgetbook/src/widgetbook_component_builder.dart';

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
