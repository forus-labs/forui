import 'package:flutter/widgets.dart';

import 'package:auto_route/annotations.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

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
class MultiSelectPage extends Sample {
  MultiSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FMultiSelect<String>(
      hint: const Text('Select a fruit'),
      format: Text.new,
      children: [for (final fruit in fruits) FSelectItem(title: Text(fruit), value:  fruit)],
    ),
  );
}

@RoutePage()
class DetailedMultiSelectPage extends Sample {
  DetailedMultiSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FMultiSelect<String>(
      hint: const Text('Type'),
      format: Text.new,
      children: const [
        FSelectItem(
          prefix: Icon(FIcons.bug),
          title: Text('Bug'),
          subtitle: Text('An unexpected problem or behavior'),
          value: 'Bug',
        ),
        FSelectItem(
          prefix: Icon(FIcons.filePlus2),
          title: Text('Feature'),
          subtitle: Text('A new feature or enhancement'),
          value: 'Feature',
        ),
        FSelectItem(
          prefix: Icon(FIcons.messageCircleQuestionMark),
          title: Text('Question'),
          subtitle: Text('A question or clarification'),
          value: 'Question',
        ),
      ],
    ),
  );
}

@RoutePage()
class SectionMultiSelectPage extends Sample {
  SectionMultiSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FMultiSelect<String>(
      hint: const Text('Select a timezone'),
      format: Text.new,
      children: [
        FSelectSection.fromMap(
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
        FSelectSection.fromMap(
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
        FSelectSection.fromMap(
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
        FSelectSection.fromMap(
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
        FSelectSection.fromMap(
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
    ),
  );
}

@RoutePage()
class DividerMultiSelectPage extends Sample {
  DividerMultiSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FMultiSelect<String>(
      hint: const Text('Select a level'),
      contentDivider: FItemDivider.full,
      format: Text.new,
      children: [
        FSelectSection.fromMap(
          label: const Text('Level 1'),
          divider: FItemDivider.indented,
          items: {
            for (final item in ['A', 'B']) item: '1$item',
          },
        ),
        FSelectSection.fromMap(
          label: const Text('Level 2'),
          items: {
            for (final item in ['A', 'B']) item: '2$item',
          },
        ),
        const FSelectItem(title: Text('Level 3'), value:  '3'),
        const FSelectItem(title: Text('Level 4'), value:  '4'),
      ],
    ),
  );
}

@RoutePage()
class SyncMultiSelectPage extends Sample {
  SyncMultiSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FMultiSelect<String>.search(
      hint: const Text('Select a fruit'),
      format: Text.new,
      filter: (query) => query.isEmpty ? fruits : fruits.where((f) => f.toLowerCase().startsWith(query.toLowerCase())),
      contentBuilder: (context, _, fruits) => [for (final fruit in fruits) FSelectItem(title: Text(fruit), value:  fruit)],
    ),
  );
}

@RoutePage()
class AsyncMultiSelectPage extends Sample {
  AsyncMultiSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FMultiSelect<String>.search(
      hint: const Text('Select a fruit'),
      format: Text.new,
      filter: (query) async {
        await Future.delayed(const Duration(seconds: 1));
        return query.isEmpty ? fruits : fruits.where((fruit) => fruit.toLowerCase().startsWith(query.toLowerCase()));
      },
      contentBuilder: (context, _, fruits) => [for (final fruit in fruits) FSelectItem(title: Text(fruit), value:  fruit)],
    ),
  );
}

@RoutePage()
class AsyncLoadingMultiSelectPage extends Sample {
  AsyncLoadingMultiSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FMultiSelect<String>.search(
      hint: const Text('Select a fruit'),
      format: Text.new,
      filter: (query) async {
        await Future.delayed(const Duration(seconds: 1));
        return query.isEmpty ? fruits : fruits.where((fruit) => fruit.toLowerCase().startsWith(query.toLowerCase()));
      },
      contentLoadingBuilder: (context, style) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Here be dragons...', style: style.textFieldStyle.contentTextStyle.resolve({})),
      ),
      contentBuilder: (context, _, fruits) => [for (final fruit in fruits) FSelectItem(title: Text(fruit), value:  fruit)],
    ),
  );
}

@RoutePage()
class AsyncErrorMultiSelectPage extends Sample {
  AsyncErrorMultiSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FMultiSelect<String>.search(
      hint: const Text('Select a fruit'),
      format: Text.new,
      filter: (query) async {
        await Future.delayed(const Duration(seconds: 1));
        throw StateError('Error loading data');
      },
      contentBuilder: (context, _, fruits) => [for (final fruit in fruits) FSelectItem(title: Text(fruit), value:  fruit)],
      contentErrorBuilder: (context, error, trace) {
        final style = context.theme.selectStyle.iconStyle;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(FIcons.messageCircleX, size: style.size, color: style.color),
        );
      },
    ),
  );
}

@RoutePage()
class ClearableMultiSelectPage extends Sample {
  ClearableMultiSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FMultiSelect<String>(
      hint: const Text('Select a fruit'),
      format: Text.new,
      clearable: true,
      children: [for (final fruit in fruits) FSelectItem(title: Text(fruit), value:  fruit)],
    ),
  );
}

@RoutePage()
class FormatMultiSelectPage extends Sample {
  static const users = [
    (firstName: 'Bob', lastName: 'Ross'),
    (firstName: 'John', lastName: 'Doe'),
    (firstName: 'Mary', lastName: 'Jane'),
    (firstName: 'Peter', lastName: 'Parker'),
  ];

  FormatMultiSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FMultiSelect<({String firstName, String lastName})>(
      hint: const Text('Select a user'),
      format: (user) => Text('${user.firstName} ${user.lastName}'),
      children: [for (final user in users) FSelectItem(title: Text(user.firstName), value:  user)],
    ),
  );
}

@RoutePage()
class MinMaxMultiSelectPage extends Sample {
  MinMaxMultiSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FMultiSelect<String>(
      hint: const Text('Select favorite fruits'),
      format: Text.new,
      min: 1,
      max: 3,
      children: [for (final fruit in fruits) FSelectItem(title: Text(fruit), value:  fruit)],
    ),
  );
}

@RoutePage()
class ScrollHandlesMultiSelectPage extends Sample {
  ScrollHandlesMultiSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FMultiSelect<String>(
      hint: const Text('Select a fruit'),
      format: Text.new,
      contentScrollHandles: true,
      children: [for (final fruit in fruits) FSelectItem(title: Text(fruit), value:  fruit)],
    ),
  );
}

@RoutePage()
class SortedMultiSelectPage extends Sample {
  SortedMultiSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FMultiSelect<String>(
      hint: const Text('Select favorite fruits'),
      format: Text.new,
      sort: (a, b) => a.compareTo(b),
      children: [for (final fruit in fruits) FSelectItem(title: Text(fruit), value:  fruit)],
    ),
  );
}

@RoutePage()
class FormMultiSelectPage extends StatefulSample {
  FormMultiSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  State<FormMultiSelectPage> createState() => _FormMultiSelectPageState();
}

class _FormMultiSelectPageState extends StatefulSampleState<FormMultiSelectPage> with SingleTickerProviderStateMixin {
  static const _departments = ['Engineering', 'Marketing', 'Sales', 'Human Resources', 'Finance'];

  final _formKey = GlobalKey<FormState>();
  late final _departmentController = FMultiSelectController<String>(vsync: this);

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.all(30.0),
    child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FMultiSelect<String>(
            controller: _departmentController,
            label: const Text('Department'),
            description: const Text('Choose your dream department(s)'),
            hint: const Text('Select departments'),
            format: Text.new,
            validator: _validateDepartment,
            children: [for (final department in _departments) FSelectItem(title: Text(department), value:  department)],
          ),
          const SizedBox(height: 25),
          FButton(
            child: const Text('Submit'),
            onPress: () {
              if (_formKey.currentState!.validate()) {
                // Form is valid, do something with departments
              }
            },
          ),
        ],
      ),
    ),
  );

  String? _validateDepartment(Set<String> departments) {
    if (departments.isEmpty) {
      return 'Please select departments';
    }
    return null;
  }

  @override
  void dispose() {
    _departmentController.dispose();
    super.dispose();
  }
}
