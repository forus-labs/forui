import 'package:flutter/widgets.dart';

import 'package:auto_route/annotations.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class PickerPage extends Sample {
  final bool loop;
  final bool builder;

  PickerPage({
    @queryParam String loop = 'false',
    @queryParam String builder = 'false',
    @queryParam super.theme,
  })  : loop = bool.tryParse(loop) ?? false,
        builder = bool.tryParse(builder) ?? false;

  @override
  Widget sample(BuildContext context) => FPicker(
        children: [
          if (builder)
            FPickerWheel.builder(
              builder: (context, index) => Text('$index'),
            )
          else
            FPickerWheel(
              loop: loop,
              children: const [
                Text('January'),
                Text('February'),
                Text('March'),
                Text('April'),
                Text('May'),
                Text('June'),
                Text('July'),
                Text('August'),
                Text('September'),
                Text('October'),
                Text('November'),
                Text('December'),
              ],
            ),
        ],
      );
}

@RoutePage()
class MultiPickerPage extends Sample {
  MultiPickerPage({
    @queryParam super.theme,
    super.maxWidth = 200,
  });

  @override
  Widget sample(BuildContext context) => FPicker(
        children: [
          const FPickerWheel(
            flex: 3,
            loop: true,
            children: [
              Text('January'),
              Text('February'),
              Text('March'),
              Text('April'),
              Text('May'),
              Text('June'),
              Text('July'),
              Text('August'),
              Text('September'),
              Text('October'),
              Text('November'),
              Text('December'),
            ],
          ),
          FPickerWheel.builder(
            flex: 2,
            builder: (context, index) => Text('${(index % 31) + 1}'),
          ),
        ],
      );
}

@RoutePage()
class SeparatedPickerPage extends Sample {
  SeparatedPickerPage({
    @queryParam super.theme,
    super.maxWidth = 200,
  });

  @override
  Widget sample(BuildContext context) => SizedBox(
        width: 200,
        child: FPicker(
          children: [
            FPickerWheel.builder(
              builder: (context, index) => Text((index % 12).toString().padLeft(2, '0')),
            ),
            const Text(':'),
            FPickerWheel.builder(
              builder: (context, index) => Text((index % 60).toString().padLeft(2, '0')),
            ),
            const FPickerWheel(
              children: [
                Text('AM'),
                Text('PM'),
              ],
            ),
          ],
        ),
      );
}
