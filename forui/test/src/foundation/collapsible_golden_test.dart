import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FCollapsible', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: const FCollapsible(
            value: 0.5,
            child: ColoredBox(color: Colors.transparent, child: SizedBox.square(dimension: 50)),
          ),
        ),
      );

      await expectBlueScreen(find.byType(TestScaffold));
    });

    for (final theme in TestScaffold.themes) {
      testWidgets('fully expanded', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: const FCollapsible(
              value: 1.0,
              child: ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('collapsible/${theme.name}/fully_expanded.png'));
      });

      testWidgets('half expanded', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: const FCollapsible(
              value: 0.5,
              child: ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('collapsible/${theme.name}/half_expanded.png'));
      });

      testWidgets('fully collapsed', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: const FCollapsible(
              value: 0.0,
              child: ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('collapsible/${theme.name}/fully_collapsed.png'));
      });
      
      testWidgets('animated with trigger', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(),
            home: AnimatedCollapsibleExample(theme: theme.data),
          ),
        );

        // Initial expanded state
        await expectLater(
          find.byType(AnimatedCollapsibleExample), 
          matchesGoldenFile('collapsible/${theme.name}/animated_expanded.png'),
        );

        // Tap the button to collapse
        await tester.tap(find.text('Toggle'));
        await tester.pump(); // Start animation
        await tester.pumpAndSettle(); // Wait for animation to complete

        // Collapsed state
        await expectLater(
          find.byType(AnimatedCollapsibleExample), 
          matchesGoldenFile('collapsible/${theme.name}/animated_collapsed.png'),
        );

        // Tap again to expand
        await tester.tap(find.text('Toggle'));
        await tester.pump(); // Start animation
        await tester.pumpAndSettle(); // Wait for animation to complete

        // Back to expanded state
        await expectLater(
          find.byType(AnimatedCollapsibleExample), 
          matchesGoldenFile('collapsible/${theme.name}/animated_expanded_again.png'),
        );
      });
    }
  });
}

class AnimatedCollapsibleExample extends StatefulWidget {
  final FThemeData theme;
  
  const AnimatedCollapsibleExample({super.key, required this.theme});
  
  @override
  State<AnimatedCollapsibleExample> createState() => _AnimatedCollapsibleExampleState();
}

class _AnimatedCollapsibleExampleState extends State<AnimatedCollapsibleExample> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isExpanded = true;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    
    // Initialize controller to show expanded state
    _controller.value = 1.0;
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return TestScaffold(
      theme: widget.theme,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FButton(
            variant: FButtonVariant.outline,
            onPressed: _toggleExpand,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Toggle'),
                const SizedBox(width: 8),
                AnimatedRotation(
                  turns: _isExpanded ? 0.0 : 0.5,
                  duration: const Duration(milliseconds: 300),
                  child: const Icon(Icons.keyboard_arrow_up, size: 16),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return FCollapsible(
                value: _animation.value,
                child: child!,
              );
            },
            child: Container(
              width: 200,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: widget.theme.colors.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: widget.theme.colors.border,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Collapsible Content',
                    style: widget.theme.typography.h5,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This content can be collapsed and expanded with a smooth animation when you click the toggle button above.',
                    style: widget.theme.typography.body2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
