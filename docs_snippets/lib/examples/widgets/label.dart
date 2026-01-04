import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class VerticalLabelPage extends Example {
  VerticalLabelPage({@queryParam super.theme}) : super(maxWidth: 320);

  @override
  Widget example(BuildContext _) => const FLabel(
    // {@highlight}
    axis: .vertical,
    // {@endhighlight}
    label: Text('Email'),
    description: Text('Enter your email address.'),
    error: Text('Please enter a valid email address.'),
    child: DecoratedBox(
      decoration: BoxDecoration(borderRadius: .all(.circular(5)), color: Colors.grey),
      child: SizedBox(width: 250, height: 30),
    ),
  );
}

@RoutePage()
class HorizontalLabelPage extends Example {
  HorizontalLabelPage({@queryParam super.theme}) : super(maxWidth: 320);

  @override
  Widget example(BuildContext _) => const FLabel(
    axis: .horizontal,
    label: Text('Accept terms and conditions'),
    description: Text('You agree to our terms and conditions.'),
    error: Text('Please accept the terms.'),
    child: DecoratedBox(
      decoration: BoxDecoration(borderRadius: .all(.circular(5)), color: Colors.grey),
      child: SizedBox.square(dimension: 16),
    ),
  );
}

@RoutePage()
class DisabledHorizontalLabelPage extends Example {
  DisabledHorizontalLabelPage({@queryParam super.theme}) : super(maxWidth: 320);

  @override
  Widget example(BuildContext _) => const FLabel(
    axis: .horizontal,
    label: Text('Accept terms and conditions'),
    description: Text('You agree to our terms and conditions.'),
    error: Text('Please accept the terms.'),
    // {@highlight}
    states: {WidgetState.disabled},
    // {@endhighlight}
    child: DecoratedBox(
      decoration: BoxDecoration(borderRadius: .all(.circular(5)), color: Colors.grey),
      child: SizedBox.square(dimension: 16),
    ),
  );
}

@RoutePage()
class ErrorHorizontalLabelPage extends Example {
  ErrorHorizontalLabelPage({@queryParam super.theme}) : super(maxWidth: 320);

  @override
  Widget example(BuildContext _) => const FLabel(
    axis: .horizontal,
    label: Text('Accept terms and conditions'),
    description: Text('You agree to our terms and conditions.'),
    error: Text('Please accept the terms.'),
    // {@highlight}
    states: {WidgetState.error},
    // {@endhighlight}
    child: DecoratedBox(
      decoration: BoxDecoration(borderRadius: .all(.circular(5)), color: Colors.grey),
      child: SizedBox.square(dimension: 16),
    ),
  );
}
