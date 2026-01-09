import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class CollapsiblePage extends StatefulExample {
  CollapsiblePage({@queryParam super.theme});

  @override
  State<CollapsiblePage> createState() => _CollapsiblePageState();
}

class _CollapsiblePageState extends StatefulExampleState<CollapsiblePage> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
  late final _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  bool _expanded = false;

  @override
  void dispose() {
    _animation.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget example(BuildContext _) => Column(
    mainAxisSize: .min,
    crossAxisAlignment: .start,
    spacing: 16,
    children: [
      FButton(
        onPress: () {
          setState(() => _expanded = !_expanded);
          _controller.toggle();
        },
        child: Text(_expanded ? 'Collapse' : 'Expand'),
      ),
      AnimatedBuilder(
        animation: _animation,
        builder: (context, child) => FCollapsible(
          value: _animation.value,
          child: FCard(
            title: const Text('Lorem ipsum'),
            child: const Text(
              'Sed ut perspiciatis unde omnis iste natus error sit voluptatem '
              'accusantium doloremque laudantium, totam rem aperiam, eaque ipsa '
              'quae ab illo inventore veritatis et quasi architecto beatae vitae '
              'dicta sunt explicabo.',
            ),
          ),
        ),
      ),
    ],
  );
}
