import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

const features = ['Keyboard navigation', 'Typeahead suggestions', 'Tab to complete'];

const fruits = ['Apple', 'Banana', 'Orange', 'Grape', 'Strawberry', 'Pineapple'];

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

enum Notification { all, direct, nothing, limitedTime, timeSensitive, selectedApps }

class _SandboxState extends State<Sandbox> with SingleTickerProviderStateMixin {
  late final FTabController c;

  @override
  void initState() {
    super.initState();
    c = FTabController(vsync: this, length: 2, initialIndex: 1);
  }

  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        FAutocomplete.builder(
          hint: 'Type to search fruits',
          filter: (query) async {
            await Future.delayed(const Duration(seconds: 1));
            return query.isEmpty
                ? fruits
                : fruits.where((fruit) => fruit.toLowerCase().startsWith(query.toLowerCase()));
          },
          contentBuilder: (context, query, suggestions) => [
            for (final suggestion in suggestions) FAutocompleteItem(value: suggestion),
          ],
        ),
        FMultiSelect<String>.rich(
          format: Text.new,
          children: const [
            FSelectItem(title: Text('Apple'), value: 'Apple'),
            FSelectItem(title: Text('Banana'), value: 'Banana'),
            FSelectItem(title: Text('Cherry'), value: 'Cherry'),
            FSelectItem(title: Text('Date'), value: 'Date'),
          ],
        ),
        FSelect<String>.rich(
          format: (s) => s,
          children: const [
            // FSelectItem(title: Text('Apple'), value:  'Apple'),
            // FSelectItem(title: Text('Banana'), value:  'Banana'),
            // FSelectItem(title: Text('Cherry'), value:  'Cherry'),
            // FSelectItem(title: Text('Date'), value:  'Date'),
          ],
        ),
      ],
    );
  }
}
