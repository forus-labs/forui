import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';

class FAccordion extends StatefulWidget {
  final String title;
  final bool initiallyExpanded;
  final VoidCallback onExpanded;
  final double childHeight;
  final double removeChildAnimationPercentage;
  final Widget child;

  const FAccordion({
    required this.child,
    required this.childHeight,
    required this.initiallyExpanded,
    required this.onExpanded,
    this.title = '',
    this.removeChildAnimationPercentage = 0,
    super.key,
  });

  @override
  _FAccordionState createState() => _FAccordionState();
}

class _FAccordionState extends State<FAccordion> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  bool _isOpened = false;

  @override
  void initState() {
    super.initState();
    _isOpened = widget.initiallyExpanded;
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      value: _isOpened ? 1.0 : 0.0,
      vsync: this,
    );
    animation = Tween<double>(
      begin: 0,
      end: 100,
    ).animate(
      CurvedAnimation(
        curve: Curves.ease,
        parent: controller,
      ),
    )..addListener(() {
        setState(() {});
      });
    _isOpened ? controller.forward() : controller.reverse();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          FTappable(
            onPress: () {
              if (_isOpened) {
                controller.reverse();
              } else {
                controller.forward();
              }
              setState(() => _isOpened = !_isOpened);
              widget.onExpanded();
            },
            child: Container(
              color: Colors.red,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(),
                    ),
                  ),
                  Transform.rotate(
                    angle: (animation.value / 100 * -180 + 90) * math.pi / 180.0,
                    child: FAssets.icons.chevronRight(
                      height: 20,
                      colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: animation.value / 100.0 * widget.childHeight,
            child: animation.value >= widget.removeChildAnimationPercentage ? widget.child : Container(),
          ),
          FDivider(
            style: context.theme.dividerStyles.horizontal.copyWith(padding: EdgeInsets.zero, color: Colors.blue),
          ),
        ],
      );
}
