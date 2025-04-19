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
    child: FSelect<String>(hint: 'Select a fruit', children: [for (final fruit in fruits) FSelectItem.text(fruit)]),
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
      popoverConstraints: const BoxConstraints(maxWidth: 400, maxHeight: 300),
      children: [
        FSelectSection(
          label: const Text('North America'),
          children: [
            FSelectItem.text('Eastern Standard Time (EST)'),
            FSelectItem.text('Central Standard Time (CST)'),
            FSelectItem.text('Mountain Standard Time (MST)'),
            FSelectItem.text('Pacific Standard Time (PST)'),
            FSelectItem.text('Alaska Standard Time (AKST)'),
            FSelectItem.text('Hawaii Standard Time (HST)'),
          ],
        ),
        FSelectSection(
          label: const Text('South America'),
          children: [
            FSelectItem.text('Argentina Time (ART)'),
            FSelectItem.text('Bolivia Time (BOT)'),
            FSelectItem.text('Brasilia Time (BRT)'),
            FSelectItem.text('Chile Standard Time (CLT)'),
          ],
        ),
        FSelectSection(
          label: const Text('Europe & Africa'),
          children: [
            FSelectItem.text('Greenwich Mean Time (GMT)'),
            FSelectItem.text('Central European Time (CET)'),
            FSelectItem.text('Eastern European Time (EET)'),
            FSelectItem.text('Western European Summer Time (WEST)'),
            FSelectItem.text('Central Africa Time (CAT)'),
            FSelectItem.text('Eastern Africa Time (EAT)'),
          ],
        ),
        FSelectSection(
          label: const Text('Asia'),
          children: [
            FSelectItem.text('Moscow Time (MSK)'),
            FSelectItem.text('India Standard Time (IST)'),
            FSelectItem.text('China Standard Time (CST)'),
            FSelectItem.text('Japan Standard Time (JST)'),
            FSelectItem.text('Korea Standard Time (KST)'),
            FSelectItem.text('Indonesia Standard Time (IST)'),
          ],
        ),
        FSelectSection(
          label: const Text('Australia & Pacific'),
          children: [
            FSelectItem.text('Australian Western Standard Time (AWST)'),
            FSelectItem.text('Australian Central Standard Time (ACST)'),
            FSelectItem.text('Australian Eastern Standard Time (AEST)'),
            FSelectItem.text('New Zealand Standard Time (NZST)'),
            FSelectItem.text('Fiji Time (FJT)'),
          ],
        ),
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
      filter:
          (query) =>
              query.isEmpty ? fruits : fruits.where((fruit) => fruit.toLowerCase().startsWith(query.toLowerCase())),
      contentBuilder: (context, data) => [for (final fruit in data.values) FSelectItem.text(fruit)],
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
      filter: (query) async {
        await Future.delayed(const Duration(seconds: 1));
        return query.isEmpty ? fruits : fruits.where((fruit) => fruit.toLowerCase().startsWith(query.toLowerCase()));
      },
      contentBuilder: (context, data) => [for (final fruit in data.values) FSelectItem.text(fruit)],
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
      filter: (query) async {
        await Future.delayed(const Duration(seconds: 1));
        return query.isEmpty ? fruits : fruits.where((fruit) => fruit.toLowerCase().startsWith(query.toLowerCase()));
      },
      searchLoadingBuilder:
          (context, style, _) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Here be dragons...', style: style.textFieldStyle.contentTextStyle.resolve({})),
          ),
      contentBuilder: (context, data) => [for (final fruit in data.values) FSelectItem.text(fruit)],
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
      filter: (query) async {
        await Future.delayed(const Duration(seconds: 1));
        throw StateError('Error loading data');
      },
      contentBuilder: (context, data) => [for (final fruit in data.values) FSelectItem.text(fruit)],
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
class ClearableSelectPage extends Sample {
  ClearableSelectPage({@queryParam super.theme, super.alignment = Alignment.topCenter});

  @override
  Widget sample(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 15),
    child: FSelect<String>(
      hint: 'Select a fruit',
      clearable: true,
      children: [for (final fruit in fruits) FSelectItem.text(fruit)],
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
      children: [for (final user in users) FSelectItem(value: user, child: Text(user.firstName))],
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
      contentScrollHandles: true,
      children: [for (final fruit in fruits) FSelectItem.text(fruit)],
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
            validator: _validateDepartment,
            children: [for (final department in _departments) FSelectItem.text(department)],
          ),
          const SizedBox(height: 25),
          FButton(
            child: const Text('Submit'),
            onPress: () {
              if (_formKey.currentState!.validate()) {
                // Form is valid, do something with department.e
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
