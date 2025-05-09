import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class CollapsiblePage extends Sample {
  CollapsiblePage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => const Demo();
}

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      FButton(onPress: _toggle, child: Text(_expanded ? 'Collapse' : 'Expand')),
      const SizedBox(height: 16),
      AnimatedBuilder(
        animation: _animation,
        builder:
            (context, child) => FCollapsible(
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
