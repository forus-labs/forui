import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

final controllers = {'default': FAccordionController(max: 1), 'max': FAccordionController(max: 2)};

@RoutePage()
class AccordionPage extends Sample {
  final FAccordionController controller;

  AccordionPage({@queryParam super.theme, @queryParam String controller = 'default'})
    : controller = controllers[controller] ?? FAccordionController();

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Column(
      children: [
        FAccordion(
          controller: controller,
          children: const [
            FAccordionItem(
              title: Text('TEST Information 2'),
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
