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
    child: FSelect<String>.rich(
      hint: 'Select a fruit',
      format: (s) => s,
      children: [for (final fruit in fruits) FSelectItem(title: Text(fruit), value:  fruit)],
    ),
  );
}

@RoutePage()
class DetailedSelectPage extends Sample {
  DetailedSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FSelect<String>.rich(
      hint: 'Type',
      format: (s) => s,
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
class SectionSelectPage extends Sample {
  SectionSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FSelect<String>.rich(
      hint: 'Select a timezone',
      format: (s) => s,
      children: [
        FSelectSection(
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
        FSelectSection(
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
        FSelectSection(
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
        FSelectSection(
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
        FSelectSection(
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
    child: FSelect<String>.rich(
      hint: 'Select a level',
      contentDivider: FItemDivider.full,
      format: (s) => s,
      children: [
        FSelectSection(
          label: const Text('Level 1'),
          divider: FItemDivider.indented,
          items: {
            for (final item in ['A', 'B']) item: '1$item',
          },
        ),
        FSelectSection(
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
class SyncSelectPage extends Sample {
  SyncSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FSelect<String>.searchBuilder(
      hint: 'Select a fruit',
      format: (s) => s,
      filter: (query) => query.isEmpty ? fruits : fruits.where((f) => f.toLowerCase().startsWith(query.toLowerCase())),
      contentBuilder: (context, _, fruits) => [for (final fruit in fruits) FSelectItem(title: Text(fruit), value:  fruit)],
    ),
  );
}

@RoutePage()
class AsyncSelectPage extends Sample {
  AsyncSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FSelect<String>.searchBuilder(
      hint: 'Select a fruit',
      format: (s) => s,
      filter: (query) async {
        await Future.delayed(const Duration(seconds: 1));
        return query.isEmpty ? fruits : fruits.where((fruit) => fruit.toLowerCase().startsWith(query.toLowerCase()));
      },
      contentBuilder: (context, _, fruits) => [for (final fruit in fruits) FSelectItem(title: Text(fruit), value:  fruit)],
    ),
  );
}

@RoutePage()
class AsyncLoadingSelectPage extends Sample {
  AsyncLoadingSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FSelect<String>.searchBuilder(
      hint: 'Select a fruit',
      format: (s) => s,
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
class AsyncErrorSelectPage extends Sample {
  AsyncErrorSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FSelect<String>.searchBuilder(
      hint: 'Select a fruit',
      format: (s) => s,
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
    child: FSelect<String>.rich(
      hint: 'Select a fruit',
      format: (s) => s,
      controller: _controller,
      children: [for (final fruit in fruits) FSelectItem(title: Text(fruit), value:  fruit)],
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
    child: FSelect<String>.rich(
      hint: 'Select a fruit',
      format: (s) => s,
      clearable: true,
      children: [for (final fruit in fruits) FSelectItem(title: Text(fruit), value:  fruit)],
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
    child: FSelect<({String firstName, String lastName})>.rich(
      hint: 'Select a user',
      format: (user) => '${user.firstName} ${user.lastName}',
      children: [for (final user in users) FSelectItem(title: Text(user.firstName), value:  user)],
    ),
  );
}

@RoutePage()
class ScrollHandlesSelectPage extends Sample {
  ScrollHandlesSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FSelect<String>.rich(
      hint: 'Select a fruit',
      format: (s) => s,
      contentScrollHandles: true,
      children: [for (final fruit in fruits) FSelectItem(title: Text(fruit), value:  fruit)],
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
          FSelect<String>.rich(
            controller: _departmentController,
            label: const Text('Department'),
            description: const Text('Choose your dream department'),
            hint: 'Select a department',
            format: (s) => s,
            validator: _validateDepartment,
            children: [for (final department in _departments) FSelectItem(title: Text(department), value:  department)],
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
