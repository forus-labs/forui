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
class SelectPage extends Sample {
  SelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FSelect<String>(
      hint: 'Select a fruit',
      format: (s) => s,
      children: [for (final fruit in fruits) FSelectItem(fruit, fruit)],
    ),
  );
}

@RoutePage()
class DetailedSelectPage extends Sample {
  DetailedSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FSelect<String>(
      hint: 'Type',
      format: (s) => s,
      children: [
        FSelectItem.from(
          prefix: const Icon(FIcons.bug),
          title: const Text('Bug'),
          subtitle: const Text('An unexpected problem or behavior'),
          value: 'Bug',
        ),
        FSelectItem.from(
          prefix: const Icon(FIcons.filePlus2),
          title: const Text('Feature'),
          subtitle: const Text('A new feature or enhancement'),
          value: 'Feature',
        ),
        FSelectItem.from(
          prefix: const Icon(FIcons.messageCircleQuestionMark),
          title: const Text('Question'),
          subtitle: const Text('A question or clarification'),
          value: 'Question',
        ),
      ],
    ),
  );
}

@RoutePage()
class SectionSelectPage extends Sample {
  SectionSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FSelect<String>(
      hint: 'Select a timezone',
      format: (s) => s,
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
class DividerSelectPage extends Sample {
  DividerSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FSelect<String>(
      hint: 'Select a level',
      contentDivider: FItemDivider.full,
      format: (s) => s,
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
        FSelectItem('Level 3', '3'),
        FSelectItem('Level 4', '4'),
      ],
    ),
  );
}

@RoutePage()
class SyncSelectPage extends Sample {
  SyncSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FSelect<String>.search(
      hint: 'Select a fruit',
      format: (s) => s,
      filter: (query) => query.isEmpty ? fruits : fruits.where((f) => f.toLowerCase().startsWith(query.toLowerCase())),
      contentBuilder: (context, data) => [for (final fruit in data.values) FSelectItem(fruit, fruit)],
    ),
  );
}

@RoutePage()
class AsyncSelectPage extends Sample {
  AsyncSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FSelect<String>.search(
      hint: 'Select a fruit',
      format: (s) => s,
      filter: (query) async {
        await Future.delayed(const Duration(seconds: 1));
        return query.isEmpty ? fruits : fruits.where((fruit) => fruit.toLowerCase().startsWith(query.toLowerCase()));
      },
      contentBuilder: (context, data) => [for (final fruit in data.values) FSelectItem(fruit, fruit)],
    ),
  );
}

@RoutePage()
class AsyncLoadingSelectPage extends Sample {
  AsyncLoadingSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FSelect<String>.search(
      hint: 'Select a fruit',
      format: (s) => s,
      filter: (query) async {
        await Future.delayed(const Duration(seconds: 1));
        return query.isEmpty ? fruits : fruits.where((fruit) => fruit.toLowerCase().startsWith(query.toLowerCase()));
      },
      searchLoadingBuilder: (context, style, _) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Here be dragons...', style: style.textFieldStyle.contentTextStyle.resolve({})),
      ),
      contentBuilder: (context, data) => [for (final fruit in data.values) FSelectItem(fruit, fruit)],
    ),
  );
}

@RoutePage()
class AsyncErrorSelectPage extends Sample {
  AsyncErrorSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FSelect<String>.search(
      hint: 'Select a fruit',
      format: (s) => s,
      filter: (query) async {
        await Future.delayed(const Duration(seconds: 1));
        throw StateError('Error loading data');
      },
      contentBuilder: (context, data) => [for (final fruit in data.values) FSelectItem(fruit, fruit)],
      searchErrorBuilder: (context, error, trace) {
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
class ToggleableSelectPage extends StatefulSample {
  ToggleableSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  State<ToggleableSelectPage> createState() => ToggleableSelectPageState();
}

class ToggleableSelectPageState extends StatefulSampleState<ToggleableSelectPage> with SingleTickerProviderStateMixin {
  late final _controller = FSelectController(vsync: this, value: 'Apple', toggleable: true);

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15.0),
    child: FSelect<String>(
      hint: 'Select a fruit',
      format: (s) => s,
      controller: _controller,
      children: [for (final fruit in fruits) FSelectItem(fruit, fruit)],
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

@RoutePage()
class ClearableSelectPage extends Sample {
  ClearableSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FSelect<String>(
      hint: 'Select a fruit',
      format: (s) => s,
      clearable: true,
      children: [for (final fruit in fruits) FSelectItem(fruit, fruit)],
    ),
  );
}

@RoutePage()
class FormatSelectPage extends Sample {
  static const users = [
    (firstName: 'Bob', lastName: 'Ross'),
    (firstName: 'John', lastName: 'Doe'),
    (firstName: 'Mary', lastName: 'Jane'),
    (firstName: 'Peter', lastName: 'Parker'),
  ];

  FormatSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FSelect<({String firstName, String lastName})>(
      hint: 'Select a user',
      format: (user) => '${user.firstName} ${user.lastName}',
      children: [for (final user in users) FSelectItem(user.firstName, user)],
    ),
  );
}

@RoutePage()
class ScrollHandlesSelectPage extends Sample {
  ScrollHandlesSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FSelect<String>(
      hint: 'Select a fruit',
      format: (s) => s,
      contentScrollHandles: true,
      children: [for (final fruit in fruits) FSelectItem(fruit, fruit)],
    ),
  );
}

@RoutePage()
class FormSelectPage extends StatefulSample {
  FormSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  State<FormSelectPage> createState() => _FormSelectPageState();
}

class _FormSelectPageState extends StatefulSampleState<FormSelectPage> with SingleTickerProviderStateMixin {
  static const _departments = ['Engineering', 'Marketing', 'Sales', 'Human Resources', 'Finance'];

  final _formKey = GlobalKey<FormState>();
  late final _departmentController = FSelectController<String>(vsync: this);

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.all(30.0),
    child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FSelect<String>(
            controller: _departmentController,
            label: const Text('Department'),
            description: const Text('Choose your dream department'),
            hint: 'Select a department',
            format: (s) => s,
            validator: _validateDepartment,
            children: [for (final department in _departments) FSelectItem(department, department)],
          ),
          const SizedBox(height: 25),
          FButton(
            child: const Text('Submit'),
            onPress: () {
              if (_formKey.currentState!.validate()) {
                // Form is valid, do something with department.
              }
            },
          ),
        ],
      ),
    ),
  );

  String? _validateDepartment(String? department) {
    if (department == null) {
      return 'Please select a department';
    }
    return null;
  }

  @override
  void dispose() {
    _departmentController.dispose();
    super.dispose();
  }
}
