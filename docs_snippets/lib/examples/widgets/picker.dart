import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class PickerPage extends Example {
  PickerPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => const FPicker(
    children: [
      FPickerWheel(
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
    ],
  );
}

@RoutePage()
class LoopPickerPage extends Example {
  LoopPickerPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => const FPicker(
    children: [
      FPickerWheel(
        // {@highlight}
        loop: true,
        // {@endhighlight}
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
    ],
  );
}

@RoutePage()
class BuilderPickerPage extends Example {
  BuilderPickerPage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) =>
      FPicker(children: [FPickerWheel.builder(builder: (context, index) => Text('$index'))]);
}

@RoutePage()
class MultiPickerPage extends Example {
  MultiPickerPage({@queryParam super.theme, super.maxWidth = 200});

  @override
  Widget example(BuildContext context) => FPicker(
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
      FPickerWheel.builder(flex: 2, builder: (context, index) => Text('${(index % 31) + 1}')),
    ],
  );
}

@RoutePage()
class SeparatedPickerPage extends Example {
  SeparatedPickerPage({@queryParam super.theme, super.maxWidth = 200});

  @override
  Widget example(BuildContext context) => SizedBox(
    width: 200,
    child: FPicker(
      children: [
        FPickerWheel.builder(builder: (context, index) => Text((index % 12).toString().padLeft(2, '0'))),
        // {@highlight}
        const Text(':'),
        // {@endhighlight}
        FPickerWheel.builder(builder: (context, index) => Text((index % 60).toString().padLeft(2, '0'))),
        const FPickerWheel(children: [Text('AM'), Text('PM')]),
      ],
    ),
  );
}
