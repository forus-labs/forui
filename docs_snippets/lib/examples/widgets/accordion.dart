import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';
import 'package:docs_snippets/main.dart';

@RoutePage()
@Options(inline: _Accordion)
class AccordionPage extends Example {
  AccordionPage({@queryParam super.theme}) : super(top: 20);

  @override
  Widget example(BuildContext _) => const _Accordion();
}

@RoutePage()
@Options(inline: _Accordion)
class MaxAccordionPage extends Example {
  MaxAccordionPage({@queryParam super.theme}) : super(top: 20);

  @override
  Widget example(BuildContext _) => const _Accordion(max: 2);
}

class _Accordion extends StatelessWidget {
  final int? max;

  const _Accordion({this.max});
  @override
  Widget build(BuildContext _) => FAccordion(
    // {@highlight}
    control: .managed(max: max),
    // {@endhighlight}
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
  );
}
