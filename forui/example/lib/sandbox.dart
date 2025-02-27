import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [
      // Material Buttons section
      const Text('Material Buttons', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ElevatedButton(onPressed: () {}, child: const Text('Elevated Button')),
      FilledButton(onPressed: () {}, child: const Text('Filled Button')),
      FilledButton.tonal(onPressed: () {}, child: const Text('Filled Tonal Button')),
      OutlinedButton(onPressed: () {}, child: const Text('Outlined Button')),
      TextButton(onPressed: () {}, child: const Text('Text Button')),

      // Forui Buttons section
      const Text('Forui Buttons', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      FButton(label: const Text('Forui Primary Button'), onPress: () {}),
      FButton(style: FButtonStyle.secondary, label: const Text('Forui Secondary Button'), onPress: () {}),
      FButton(style: FButtonStyle.outline, label: const Text('Forui Outline Button'), onPress: () {}),
      FButton(style: FButtonStyle.ghost, label: const Text('Forui Ghost Button'), onPress: () {}),
      FButton(style: FButtonStyle.destructive, label: const Text('Forui Destructive Button'), onPress: () {}),

      // Floating action button
      const Text('Floating Action Button', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Align(child: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.navigation))),

      // Icon Button
      const Text('Icon Button', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Align(child: IconButton(icon: const Icon(Icons.volume_up), tooltip: 'Increase volume by 10', onPressed: () {})),

      // Segmented Button
      const Text('Segmented Button', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      SegmentedButton<String>(
        segments: const <ButtonSegment<String>>[
          ButtonSegment<String>(value: 'XS', label: Text('XS')),
          ButtonSegment<String>(value: 'S', label: Text('S')),
          ButtonSegment<String>(value: 'M', label: Text('M')),
          ButtonSegment<String>(value: 'L', label: Text('L')),
          ButtonSegment<String>(value: 'XL', label: Text('XL')),
        ],
        selected: const {'M'},
        onSelectionChanged: (_) {},
        multiSelectionEnabled: true,
      ),

      // Checkbox
      const Text('Checkbox', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(value: true, onChanged: (_) {}),
          const SizedBox(width: 16),
          Checkbox(value: false, onChanged: (_) {}),
        ],
      ),

      // Chip
      const Text('Chip', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Wrap(
        spacing: 8.0,
        children: [
          Chip(avatar: const CircleAvatar(child: Text('M')), label: const Text('Material Chip'), onDeleted: () {}),
          ActionChip(avatar: const CircleAvatar(child: Text('A')), label: const Text('Action Chip'), onPressed: () {}),
          FilterChip(
            avatar: const CircleAvatar(child: Text('F')),
            label: const Text('Filter Chip'),
            selected: true,
            onSelected: (_) {},
          ),
          InputChip(
            avatar: const CircleAvatar(child: Text('I')),
            label: const Text('Input Chip'),
            onPressed: () {},
            onDeleted: () {},
          ),
        ],
      ),

      // Date Picker
      const Text('Date Picker', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ElevatedButton(
        onPressed: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2030),
          );
        },
        child: const Text('Show Material Date Picker'),
      ),

      // Menu
      const Text('Menu', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      PopupMenuButton<String>(
        onSelected: (_) {},
        itemBuilder:
            (context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(value: 'item1', child: Text('Item 1')),
              const PopupMenuItem<String>(value: 'item2', child: Text('Item 2')),
              const PopupMenuItem<String>(value: 'item3', child: Text('Item 3')),
            ],
        child: const Padding(padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), child: Text('Show Menu')),
      ),

      // Radio
      const Text('Radio', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Radio<int>(value: 0, groupValue: 0, onChanged: (_) {}),
          const SizedBox(width: 16),
          Radio<int>(value: 1, groupValue: 0, onChanged: (_) {}),
          const SizedBox(width: 16),
          Radio<int>(value: 2, groupValue: 0, onChanged: (_) {}),
        ],
      ),

      // Slider
      const Text('Slider', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Slider(value: 0.5, onChanged: (_) {}),

      // Switch
      const Text('Switch', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Switch(value: true, onChanged: (_) {}),
          const SizedBox(width: 16),
          Switch(value: false, onChanged: (_) {}),
        ],
      ),

      // Time Picker
      const Text('Time Picker', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ElevatedButton(
        onPressed: () {
          showTimePicker(context: context, initialTime: TimeOfDay.now());
        },
        child: const Text('Show Material Time Picker'),
      ),

      // TextField
      const Text('TextField', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const TextField(decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Password')),

      // Forui TextField
      const Text('Forui TextField', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const FTextField(
        label: Text('Username'),
        hint: 'JaneDoe',
      ),
      const FTextField.password(
        hint: 'Enter your password',
      ),
      
      // TabBar 
      const Text('TabBar with DefaultTabController', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(
        height: 150,
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(text: 'Tab 1', icon: Icon(Icons.looks_one)),
                  Tab(text: 'Tab 2', icon: Icon(Icons.looks_two)),
                  Tab(text: 'Tab 3', icon: Icon(Icons.looks_3)),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Center(child: Text('Content 1')),
                    Center(child: Text('Content 2')),
                    Center(child: Text('Content 3')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      
      // AlertDialog
      const Text('AlertDialog', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: const Text('Confirm Action'),
                content: const Text('Are you sure you want to proceed with this action?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
          );
        },
        child: const Text('Show Alert Dialog'),
      ),
      
      // BottomSheet
      const Text('BottomSheet', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Bottom Sheet Content',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    const Text('This is a modal bottom sheet that slides up from the bottom of the screen.'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
          );
        },
        child: const Text('Show Bottom Sheet'),
      ),
      
      // Card
      const Text('Card', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Material Card',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Cards contain content and actions about a single subject.',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
      
      // ListTile
      const Text('ListTile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Card(
        margin: EdgeInsets.zero,
        child: Column(
          children: [
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: const Text('John Doe'),
              subtitle: const Text('Software Developer'),
              trailing: IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person_outline)),
              title: const Text('Jane Smith'),
              subtitle: const Text('UX Designer'),
              trailing: IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person_2_outlined)),
              title: const Text('Robert Johnson'),
              subtitle: const Text('Product Manager'),
              trailing: IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      
      // SnackBar
      const Text('SnackBar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('This is a snackbar message'),
              action: SnackBarAction(
                label: 'UNDO',
                onPressed: () {},
              ),
              duration: const Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        child: const Text('Show SnackBar'),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) => items[index],
      ),
    );
  }
}
