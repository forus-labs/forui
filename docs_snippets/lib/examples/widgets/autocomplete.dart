import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';
import 'package:docs_snippets/main.dart';

const features = ['Keyboard navigation', 'Typeahead suggestions', 'Tab to complete'];

const fruits = ['Apple', 'Banana', 'Orange', 'Grape', 'Strawberry', 'Pineapple'];

const timezones = {
  'North America': [
    'Eastern Standard Time (EST)',
    'Central Standard Time (CST)',
    'Mountain Standard Time (MST)',
    'Pacific Standard Time (PST)',
    'Alaska Standard Time (AKST)',
    'Hawaii Standard Time (HST)',
  ],
  'South America': ['Argentina Time (ART)', 'Bolivia Time (BOT)', 'Brasilia Time (BRT)', 'Chile Standard Time (CLT)'],
  'Europe & Africa': [
    'Greenwich Mean Time (GMT)',
    'Central European Time (CET)',
    'Eastern European Time (EET)',
    'Western European Summer Time (WEST)',
    'Central Africa Time (CAT)',
    'Eastern Africa Time (EAT)',
  ],
  'Asia': [
    'Moscow Time (MSK)',
    'India Standard Time (IST)',
    'China Standard Time (CST)',
    'Japan Standard Time (JST)',
    'Korea Standard Time (KST)',
    'Indonesia Standard Time (IST)',
  ],
  'Australia & Pacific': [
    'Australian Western Standard Time (AWST)',
    'Australian Central Standard Time (ACST)',
    'Australian Eastern Standard Time (AEST)',
    'New Zealand Standard Time (NZST)',
    'Fiji Time (FJT)',
  ],
};

@RoutePage()
class AutocompletePage extends Example {
  AutocompletePage({@queryParam super.theme});

  @override
  Widget example(BuildContext _) =>
      FAutocomplete(label: const Text('Autocomplete'), hint: 'What can it do?', items: features);
}

@RoutePage()
class DetailedAutocompletePage extends Example {
  DetailedAutocompletePage({@queryParam super.theme}) : super(alignment: .topCenter, top: 20);

  @override
  Widget example(BuildContext _) => FAutocomplete.builder(
    hint: 'Type to search',
    filter: (query) => const ['Bug', 'Feature', 'Question'].where((i) => i.toLowerCase().contains(query.toLowerCase())),
    contentBuilder: (context, query, suggestions) => [
      for (final suggestion in suggestions)
        switch (suggestion) {
          'Bug' => .item(
            value: 'Bug',
            prefix: const Icon(FIcons.bug),
            title: const Text('Bug'),
            subtitle: const Text('An unexpected problem or behavior'),
          ),
          'Feature' => .item(
            value: 'Feature',
            prefix: const Icon(FIcons.filePlusCorner),
            title: const Text('Feature'),
            subtitle: const Text('A new feature or enhancement'),
          ),
          'Question' => .item(
            value: 'Question',
            prefix: const Icon(FIcons.messageCircleQuestionMark),
            title: const Text('Question'),
            subtitle: const Text('A question or clarification'),
          ),
          _ => .item(value: suggestion),
        },
    ],
  );
}

@RoutePage()
@Options(include: [timezones])
class SectionAutocompletePage extends Example {
  SectionAutocompletePage({@queryParam super.theme}) : super(alignment: .topCenter, top: 20);

  @override
  Widget example(BuildContext _) => FAutocomplete.builder(
    hint: 'Type to search timezones',
    filter: (query) => timezones.values
        .expand((list) => list)
        .where((timezone) => timezone.toLowerCase().contains(query.toLowerCase())),
    contentBuilder: (context, query, suggestions) => [
      for (final MapEntry(key: label, value: zones) in timezones.entries)
        if (zones.where(suggestions.contains).toList() case final zones when zones.isNotEmpty)
          .section(label: Text(label), items: zones),
    ],
  );
}

@RoutePage()
class DividerAutocompletePage extends Example {
  DividerAutocompletePage({@queryParam super.theme}) : super(alignment: .topCenter, top: 20);

  @override
  Widget example(BuildContext _) => FAutocomplete.builder(
    hint: 'Type to search levels',
    filter: (query) =>
        const ['1A', '1B', '2A', '2B', '3', '4'].where((i) => i.toLowerCase().contains(query.toLowerCase())),
    contentBuilder: (context, query, suggestions) => <FAutocompleteItemMixin>[
      .richSection(
        label: const Text('Level 1'),
        divider: .indented,
        children: [
          if (suggestions.contains('1A')) .item(value: '1A'),
          if (suggestions.contains('1B')) .item(value: '1B'),
        ],
      ),
      .section(label: const Text('Level 2'), items: ['2A', '2B'].where(suggestions.contains).toList()),
      if (suggestions.contains('3')) .item(value: '3'),
      if (suggestions.contains('4')) .item(value: '4'),
    ].where((item) => item is! FAutocompleteSection || item.children.isNotEmpty).toList(),
  );
}

@RoutePage()
@Options(include: [fruits])
class AsyncAutocompletePage extends Example {
  AsyncAutocompletePage({@queryParam super.theme}) : super(alignment: .topCenter, top: 20);

  @override
  Widget example(BuildContext _) => FAutocomplete.builder(
    hint: 'Type to search fruits',
    filter: (query) async {
      await Future.delayed(const Duration(seconds: 3));
      return query.isEmpty ? fruits : fruits.where((fruit) => fruit.toLowerCase().startsWith(query.toLowerCase()));
    },
    contentBuilder: (context, query, values) => [for (final fruit in values) .item(value: fruit)],
  );
}

@RoutePage()
@Options(include: [fruits])
class AsyncLoadingAutocompletePage extends Example {
  AsyncLoadingAutocompletePage({@queryParam super.theme}) : super(alignment: .topCenter, top: 20);

  @override
  Widget example(BuildContext _) => FAutocomplete.builder(
    hint: 'Type to search fruits',
    filter: (query) async {
      await Future.delayed(const Duration(seconds: 3));
      return query.isEmpty ? fruits : fruits.where((fruit) => fruit.toLowerCase().startsWith(query.toLowerCase()));
    },
    // {@highlight}
    contentLoadingBuilder: (context, style) => Padding(
      padding: const .all(14.0),
      child: Text('Here be dragons...', style: style.emptyTextStyle),
    ),
    // {@endhighlight}
    contentBuilder: (context, query, suggestions) => [for (final suggestion in suggestions) .item(value: suggestion)],
  );
}

@RoutePage()
@Options(include: [fruits])
class AsyncErrorAutocompletePage extends Example {
  AsyncErrorAutocompletePage({@queryParam super.theme}) : super(alignment: .topCenter, top: 20);

  @override
  Widget example(BuildContext _) => FAutocomplete.builder(
    hint: 'Type to search fruits',
    filter: (query) async {
      await Future.delayed(const Duration(seconds: 3));
      throw StateError('Error loading data');
    },
    contentBuilder: (context, query, values) => [for (final fruit in values) .item(value: fruit)],
    // {@highlight}
    contentErrorBuilder: (context, error, trace) => Padding(
      padding: const .all(14.0),
      child: Icon(FIcons.circleX, size: 15, color: context.theme.colors.primary),
    ),
    // {@endhighlight}
  );
}

@RoutePage()
@Options(include: [fruits])
class ClearableAutocompletePage extends Example {
  ClearableAutocompletePage({@queryParam super.theme}) : super(alignment: .topCenter, top: 20);

  @override
  Widget example(BuildContext _) => FAutocomplete(
    hint: 'Type to search fruits',
    // {@highlight}
    clearable: (value) => value.text.isNotEmpty,
    // {@endhighlight}
    items: fruits,
  );
}

@RoutePage()
class FormAutocompletePage extends StatefulExample {
  FormAutocompletePage({@queryParam super.theme}) : super(alignment: .topCenter, top: 20);

  @override
  State<FormAutocompletePage> createState() => _FormAutocompletePageState();
}

class _FormAutocompletePageState extends StatefulExampleState<FormAutocompletePage> {
  final _key = GlobalKey<FormState>();

  @override
  Widget example(BuildContext _) => Form(
    key: _key,
    child: Column(
      crossAxisAlignment: .start,
      children: [
        FAutocomplete(
          label: const Text('Department'),
          description: const Text('Type to search your dream department'),
          hint: 'Search departments',
          validator: (department) => department == null || department.isEmpty ? 'Please select a department' : null,
          items: const ['Engineering', 'Marketing', 'Sales', 'Human Resources', 'Finance'],
        ),
        const SizedBox(height: 25),
        FButton(
          child: const Text('Submit'),
          onPress: () {
            if (_key.currentState!.validate()) {
              // Form is valid, do something with department.
            }
          },
        ),
      ],
    ),
  );
}
