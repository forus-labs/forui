import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';

import 'package:docs_snippets/example.dart';
import 'package:docs_snippets/main.dart';

@RoutePage()
@Options(include: [Label])
class ResizablePage extends Example {
  ResizablePage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      border: .all(color: context.theme.colors.border),
      borderRadius: .circular(8),
    ),
    child: FResizable(
      axis: .vertical,
      crossAxisExtent: 300,
      children: [
        .region(
          initialExtent: 250,
          minExtent: 100,
          builder: (_, data, _) => Label(data: data, icon: FIcons.sunrise, label: 'Morning'),
        ),
        .region(
          initialExtent: 100,
          minExtent: 100,
          builder: (_, data, _) => Label(data: data, icon: FIcons.sun, label: 'Afternoon'),
        ),
        .region(
          initialExtent: 250,
          minExtent: 100,
          builder: (_, data, _) => Label(data: data, icon: FIcons.sunset, label: 'Evening'),
        ),
      ],
    ),
  );
}

@RoutePage()
@Options(include: [Label])
class NoCascadingResizablePage extends Example {
  NoCascadingResizablePage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      border: .all(color: context.theme.colors.border),
      borderRadius: .circular(8),
    ),
    child: FResizable(
      // {@highlight}
      control: const .managed(),
      // {@endhighlight}
      axis: .vertical,
      crossAxisExtent: 300,
      children: [
        .region(
          initialExtent: 200,
          minExtent: 100,
          builder: (_, data, _) => Label(data: data, icon: FIcons.sunrise, label: 'Morning'),
        ),
        .region(
          initialExtent: 200,
          minExtent: 100,
          builder: (_, data, _) => Label(data: data, icon: FIcons.sun, label: 'Afternoon'),
        ),
        .region(
          initialExtent: 200,
          minExtent: 100,
          builder: (_, data, _) => Label(data: data, icon: FIcons.sunset, label: 'Evening'),
        ),
      ],
    ),
  );
}

class Label extends StatelessWidget {
  static final format = DateFormat.jm(); // Requires package:intl

  final FResizableRegionData data;
  final IconData icon;
  final String label;

  const Label({required this.data, required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    final FThemeData(:colors, :typography) = context.theme;
    final start = DateTime.fromMillisecondsSinceEpoch(
      (data.offsetPercentage.min * Duration.millisecondsPerDay).round(),
      isUtc: true,
    );

    final end = DateTime.fromMillisecondsSinceEpoch(
      (data.offsetPercentage.max * Duration.millisecondsPerDay).round(),
      isUtc: true,
    );

    return Align(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Row(
            mainAxisSize: .min,
            mainAxisAlignment: .center,
            children: [
              Icon(icon, size: 15, color: colors.foreground),
              const SizedBox(width: 3),
              Text(label, style: typography.sm.copyWith(color: colors.foreground)),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            '${format.format(start)} - ${format.format(end)}',
            style: typography.sm.copyWith(color: colors.foreground),
          ),
        ],
      ),
    );
  }
}

@RoutePage()
class HorizontalResizablePage extends Example {
  HorizontalResizablePage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      border: .all(color: context.theme.colors.border),
      borderRadius: .circular(8),
    ),
    child: FResizable(
      // {@highlight}
      axis: .horizontal,
      // {@endhighlight}
      crossAxisExtent: 300,
      children: [
        .region(
          initialExtent: 100,
          minExtent: 100,
          builder: (context, data, _) => Align(child: Text('Sidebar', style: context.theme.typography.sm)),
        ),
        .region(
          initialExtent: 300,
          minExtent: 100,
          builder: (context, data, _) => Align(child: Text('Content', style: context.theme.typography.sm)),
        ),
      ],
    ),
  );
}

@RoutePage()
class DividerResizablePage extends Example {
  DividerResizablePage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      border: .all(color: context.theme.colors.border),
      borderRadius: .circular(8),
    ),
    child: FResizable(
      axis: .horizontal,
      // {@highlight}
      divider: .divider,
      // {@endhighlight}
      crossAxisExtent: 300,
      children: [
        .region(
          initialExtent: 100,
          minExtent: 100,
          builder: (context, data, _) => Align(child: Text('Sidebar', style: context.theme.typography.sm)),
        ),
        .region(
          initialExtent: 300,
          minExtent: 100,
          builder: (context, data, _) => Align(child: Text('Content', style: context.theme.typography.sm)),
        ),
      ],
    ),
  );
}

@RoutePage()
class NoDividerResizablePage extends Example {
  NoDividerResizablePage({@queryParam super.theme});

  @override
  Widget example(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      border: .all(color: context.theme.colors.border),
      borderRadius: .circular(8),
    ),
    child: FResizable(
      axis: .horizontal,
      // {@highlight}
      divider: .none,
      // {@endhighlight}
      crossAxisExtent: 300,
      children: [
        .region(
          initialExtent: 100,
          minExtent: 100,
          builder: (context, data, _) => Align(child: Text('Sidebar', style: context.theme.typography.sm)),
        ),
        .region(
          initialExtent: 300,
          minExtent: 100,
          builder: (context, data, _) => Align(child: Text('Content', style: context.theme.typography.sm)),
        ),
      ],
    ),
  );
}
