import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

String path(String str) => kIsWeb ? 'assets/$str' : str;

@RoutePage()
class CardPage extends Example {
  CardPage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) => FCard(
    image: Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(path('avatar.png')), fit: .cover),
      ),
      height: 200,
    ),
    title: const Text('Gratitude'),
    subtitle: const Text('The quality of being thankful; readiness to show appreciation for and to return kindness.'),
  );
}
