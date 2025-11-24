import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:auto_route/auto_route.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class AccordionPage extends StatefulSample {
  final int? max;

  AccordionPage({@queryParam this.max, @queryParam super.theme});

  @override
  State<AccordionPage> createState() => _AccordionPageState();
}

class _AccordionPageState extends StatefulSampleState<AccordionPage> {
  late final _controller = FAccordionController(max: widget.max);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => Padding(
        padding: const .only(top: 20),
        child: Column(
          children: [
            FAccordion(
              controller: _controller,
              children: const [
                FAccordionItem(
                  title: Text('Production Information'),
                  child: Text('''
Our flagship product combines cutting-edge technology with sleek design. Built with premium materials, it offers unparalleled performance and reliability.

Key features include advanced processing capabilities, and an intuitive user interface designed for both beginners and experts.
            '''),
                ),
                FAccordionItem(
                  initiallyExpanded: true,
                  title: Text('Shipping Details'),
                  child: Text('''
We offer worldwide shipping through trusted courier partners. Standard delivery takes 3-5 business days, while express shipping ensures delivery within 1-2 business days.

All orders are carefully packaged and fully insured. Track your shipment in real-time through our dedicated tracking portal.
            '''),
                ),
                FAccordionItem(
                  title: Text('Return Policy'),
                  child: Text('''
We stand behind our products with a comprehensive 30-day return policy. If you're not completely satisfied, simply return the item in its original condition.

Our hassle-free return process includes free return shipping and full refunds processed within 48 hours of receiving the returned item.
            '''),
                ),
              ],
            ),
          ],
        ),
      );
}
