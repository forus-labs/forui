import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';
import 'package:docs_snippets/main.dart';

const fruits = [
  'Apple',
  'Banana',
  'Blueberry',
  'Grapes',
  'Lemon',
  'Mango',
  'Kiwi',
  'Orange',
  'Peach',
  'Pear',
  'Pineapple',
  'Plum',
  'Raspberry',
  'Strawberry',
  'Watermelon',
];

@RoutePage()
@Options(include: [fruits])
class SelectPage extends Example {
  SelectPage({@queryParam super.theme}) : super(alignment: .topCenter, top: 20);

  @override
  Widget example(BuildContext context) => FSelect<String>.rich(
    hint: 'Select a fruit',
    format: (s) => s,
    children: [for (final fruit in fruits) .item(title: Text(fruit), value: fruit)],
  );
}

@RoutePage()
class DetailedSelectPage extends Example {
  DetailedSelectPage({@queryParam super.theme}) : super(alignment: .topCenter, top: 20);

  @override
  Widget example(BuildContext context) => FSelect<String>.rich(
    hint: 'Type',
    format: (s) => s,
    children: [
      .item(
        prefix: const Icon(FIcons.bug),
        title: const Text('Bug'),
        subtitle: const Text('An unexpected problem or behavior'),
        value: 'Bug',
      ),
      .item(
        prefix: const Icon(FIcons.filePlusCorner),
        title: const Text('Feature'),
        subtitle: const Text('A new feature or enhancement'),
        value: 'Feature',
      ),
      .item(
        prefix: const Icon(FIcons.messageCircleQuestionMark),
        title: const Text('Question'),
        subtitle: const Text('A question or clarification'),
        value: 'Question',
      ),
    ],
  );
}

@RoutePage()
class SectionSelectPage extends Example {
  SectionSelectPage({@queryParam super.theme}) : super(alignment: .topCenter, top: 20);

  @override
  Widget example(BuildContext context) => FSelect<String>.rich(
    hint: 'Select a timezone',
    format: (s) => s,
    children: [
      .section(
        label: const Text('North America'),
        items: {
          for (final item in [
            'Eastern Standard Time (EST)',
            'Central Standard Time (CST)',
            'Mountain Standard Time (MST)',
            'Pacific Standard Time (PST)',
            'Alaska Standard Time (AKST)',
            'Hawaii Standard Time (HST)',
          ])
            item: item,
        },
      ),
      .section(
        label: const Text('South America'),
        items: {
          for (final item in [
            'Argentina Time (ART)',
            'Bolivia Time (BOT)',
            'Brasilia Time (BRT)',
            'Chile Standard Time (CLT)',
          ])
            item: item,
        },
      ),
      .section(
        label: const Text('Europe & Africa'),
        items: {
          for (final item in [
            'Greenwich Mean Time (GMT)',
            'Central European Time (CET)',
            'Eastern European Time (EET)',
            'Western European Summer Time (WEST)',
            'Central Africa Time (CAT)',
            'Eastern Africa Time (EAT)',
          ])
            item: item,
        },
      ),
      .section(
        label: const Text('Asia'),
        items: {
          for (final item in [
            'Moscow Time (MSK)',
            'India Standard Time (IST)',
            'China Standard Time (CST)',
            'Japan Standard Time (JST)',
            'Korea Standard Time (KST)',
            'Indonesia Standard Time (IST)',
          ])
            item: item,
        },
      ),
      .section(
        label: const Text('Australia & Pacific'),
        items: {
          for (final item in [
            'Australian Western Standard Time (AWST)',
            'Australian Central Standard Time (ACST)',
            'Australian Eastern Standard Time (AEST)',
            'New Zealand Standard Time (NZST)',
            'Fiji Time (FJT)',
          ])
            item: item,
        },
      ),
    ],
  );
}

@RoutePage()
class DividerSelectPage extends Example {
  DividerSelectPage({@queryParam super.theme}) : super(alignment: .topCenter, top: 20);

  @override
  Widget example(BuildContext context) => FSelect<String>.rich(
    hint: 'Select a level',
    // {@highlight}
    contentDivider: .full,
    // {@endhighlight}
    format: (s) => s,
    children: [
      .section(
        label: const Text('Level 1'),
        // {@highlight}
        divider: .indented,
        // {@endhighlight}
        items: {
          for (final item in ['A', 'B']) item: '1$item',
        },
      ),
      .section(
        label: const Text('Level 2'),
        items: {
          for (final item in ['A', 'B']) item: '2$item',
        },
      ),
      .item(title: const Text('Level 3'), value: '3'),
      .item(title: const Text('Level 4'), value: '4'),
    ],
  );
}

@RoutePage()
@Options(include: [fruits])
class SyncSelectPage extends Example {
  SyncSelectPage({@queryParam super.theme}) : super(alignment: .topCenter, top: 20);

  @override
  Widget example(BuildContext context) => FSelect<String>.searchBuilder(
    hint: 'Select a fruit',
    format: (s) => s,
    // {@highlight}
    filter: (query) => query.isEmpty ? fruits : fruits.where((f) => f.toLowerCase().startsWith(query.toLowerCase())),
    // {@endhighlight}
    contentBuilder: (context, _, fruits) => [for (final fruit in fruits) .item(title: Text(fruit), value: fruit)],
  );
}

@RoutePage()
@Options(include: [fruits])
class AsyncSelectPage extends Example {
  AsyncSelectPage({@queryParam super.theme}) : super(alignment: .topCenter, top: 20);

  @override
  Widget example(BuildContext context) => FSelect<String>.searchBuilder(
    hint: 'Select a fruit',
    format: (s) => s,
    // {@highlight}
    filter: (query) async {
      await Future.delayed(const Duration(seconds: 1));
      return query.isEmpty ? fruits : fruits.where((fruit) => fruit.toLowerCase().startsWith(query.toLowerCase()));
    },
    // {@endhighlight}
    contentBuilder: (context, _, fruits) => [for (final fruit in fruits) .item(title: Text(fruit), value: fruit)],
  );
}

@RoutePage()
@Options(include: [fruits])
class AsyncLoadingSelectPage extends Example {
  AsyncLoadingSelectPage({@queryParam super.theme}) : super(alignment: .topCenter, top: 20);

  @override
  Widget example(BuildContext context) => FSelect<String>.searchBuilder(
    hint: 'Select a fruit',
    format: (s) => s,
    filter: (query) async {
      await Future.delayed(const Duration(seconds: 1));
      return query.isEmpty ? fruits : fruits.where((fruit) => fruit.toLowerCase().startsWith(query.toLowerCase()));
    },
    // {@highlight}
    contentLoadingBuilder: (context, style) => Padding(
      padding: const .all(8.0),
      child: Text('Here be dragons...', style: style.fieldStyle.contentTextStyle.resolve({})),
    ),
    // {@endhighlight}
    contentBuilder: (context, _, fruits) => [for (final fruit in fruits) .item(title: Text(fruit), value: fruit)],
  );
}

@RoutePage()
@Options(include: [fruits])
class AsyncErrorSelectPage extends Example {
  AsyncErrorSelectPage({@queryParam super.theme}) : super(alignment: .topCenter, top: 20);

  @override
  Widget example(BuildContext context) => FSelect<String>.searchBuilder(
    hint: 'Select a fruit',
    format: (s) => s,
    filter: (query) async {
      await Future.delayed(const Duration(seconds: 1));
      throw StateError('Error loading data');
    },
    contentBuilder: (context, _, fruits) => [for (final fruit in fruits) .item(title: Text(fruit), value: fruit)],
    // {@highlight}
    contentErrorBuilder: (context, error, trace) {
      final style = context.theme.selectStyle.fieldStyle.iconStyle.resolve({});
      return Padding(
        padding: const .all(8.0),
        child: Icon(FIcons.messageCircleX, size: style.size, color: style.color),
      );
    },
    // {@endhighlight}
  );
}

@RoutePage()
@Options(include: [fruits])
class ToggleableSelectPage extends Example {
  ToggleableSelectPage({@queryParam super.theme}) : super(alignment: .topCenter, top: 20);

  @override
  Widget example(BuildContext context) => FSelect<String>.rich(
    // {@highlight}
    control: const .managed(initial: 'Apple', toggleable: true),
    // {@endhighlight}
    hint: 'Select a fruit',
    format: (s) => s,
    children: [for (final fruit in fruits) .item(title: Text(fruit), value: fruit)],
  );
}

@RoutePage()
@Options(include: [fruits])
class ClearableSelectPage extends Example {
  ClearableSelectPage({@queryParam super.theme}) : super(alignment: .topCenter, top: 20);

  @override
  Widget example(BuildContext context) => FSelect<String>.rich(
    hint: 'Select a fruit',
    format: (s) => s,
    // {@highlight}
    clearable: true,
    // {@endhighlight}
    children: [for (final fruit in fruits) .item(title: Text(fruit), value: fruit)],
  );
}

@RoutePage()
class FormatSelectPage extends Example {
  static const users = [
    (firstName: 'Bob', lastName: 'Ross'),
    (firstName: 'John', lastName: 'Doe'),
    (firstName: 'Mary', lastName: 'Jane'),
    (firstName: 'Peter', lastName: 'Parker'),
  ];

  FormatSelectPage({@queryParam super.theme}) : super(alignment: .topCenter, top: 20);

  @override
  Widget example(BuildContext context) => FSelect<({String firstName, String lastName})>.rich(
    hint: 'Select a user',
    // {@highlight}
    format: (user) => '${user.firstName} ${user.lastName}',
    // {@endhighlight}
    children: [for (final user in users) .item(title: Text(user.firstName), value: user)],
  );
}

@RoutePage()
class FormSelectPage extends StatefulExample {
  FormSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter, super.top = 30});

  @override
  State<FormSelectPage> createState() => _FormSelectPageState();
}

class _FormSelectPageState extends StatefulExampleState<FormSelectPage> with SingleTickerProviderStateMixin {
  final _key = GlobalKey<FormState>();

  @override
  Widget example(BuildContext context) => Form(
    key: _key,
    child: Column(
      crossAxisAlignment: .start,
      spacing: 25,
      children: [
        FSelect<String>.rich(
          label: const Text('Department'),
          description: const Text('Choose your dream department'),
          hint: 'Select a department',
          format: (s) => s,
          validator: (department) => department == null ? 'Please select a department' : null,
          children: [
            for (final department in const ['Engineering', 'Marketing', 'Sales', 'Human Resources', 'Finance'])
              .item(title: Text(department), value: department),
          ],
        ),
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
