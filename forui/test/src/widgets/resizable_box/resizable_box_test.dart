import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

void main() {
  final top = FResizable.raw(
    initialSize: 30,
    sliderSize: 10,
    builder: (context, snapshot, child) => const SizedBox(),
  );

  final bottom = FResizable.raw(
    initialSize: 70,
    sliderSize: 10,
    builder: (context, snapshot, child) => const SizedBox(),
  );

  for (final (index, constructor) in [
    () => FResizableBox(
          crossAxisExtent: 0,
          axis: Axis.vertical,
          interaction: const FResizableInteraction.resize(),
          children: [top, bottom],
        ),
    () => FResizableBox(
          crossAxisExtent: 10,
          axis: Axis.vertical,
          interaction: const FResizableInteraction.selectAndResize(-1),
          children: [top, bottom],
        ),
    () => FResizableBox(
          crossAxisExtent: 10,
          axis: Axis.vertical,
          interaction: const FResizableInteraction.selectAndResize(2),
          children: [top, bottom],
        ),
  ].indexed) {
    test('[$index] constructor throws error', () => expect(constructor, throwsAssertionError));
  }

  testWidgets('vertical drag downwards', (tester) async {
    final vertical = FResizableBox(
      crossAxisExtent: 50,
      axis: Axis.vertical,
      interaction: const FResizableInteraction.resize(),
      children: [top, bottom],
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(body: Center(child: vertical)),
      ),
    );

    await tester.timedDrag(find.byType(GestureDetector).at(1), const Offset(0, 100), const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(tester.getSize(find.byType(FResizable).first), const Size(50, 80));
    expect(tester.getSize(find.byType(FResizable).last), const Size(50, 20));
  });

  testWidgets('no vertical drag when disabled', (tester) async {
    final vertical = FResizableBox(
      crossAxisExtent: 50,
      axis: Axis.vertical,
      interaction: const FResizableInteraction.selectAndResize(1),
      children: [top, bottom],
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(body: Center(child: vertical)),
      ),
    );

    await tester.tap(find.byType(GestureDetector).at(3));

    await tester.timedDrag(find.byType(GestureDetector).at(1), const Offset(0, 100), const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(tester.getSize(find.byType(FResizable).first), const Size(50, 30));
    expect(tester.getSize(find.byType(FResizable).last), const Size(50, 70));
  });

  testWidgets('vertical drag upwards', (tester) async {
    final vertical = FResizableBox(
      crossAxisExtent: 50,
      axis: Axis.vertical,
      interaction: const FResizableInteraction.selectAndResize(0),
      children: [top, bottom],
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(body: Center(child: vertical)),
      ),
    );

    await tester.timedDrag(find.byType(GestureDetector).at(1), const Offset(0, -100), const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(tester.getSize(find.byType(FResizable).first), const Size(50, 20));
    expect(tester.getSize(find.byType(FResizable).last), const Size(50, 80));
  });

  testWidgets('horizontal drag right', (tester) async {
    final horizontal = FResizableBox(
      crossAxisExtent: 50,
      axis: Axis.horizontal,
      interaction: const FResizableInteraction.selectAndResize(0),
      children: [top, bottom],
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(body: Center(child: horizontal)),
      ),
    );

    await tester.timedDrag(find.byType(GestureDetector).at(1), const Offset(100, 0), const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(tester.getSize(find.byType(FResizable).first), const Size(80, 50));
    expect(tester.getSize(find.byType(FResizable).last), const Size(20, 50));
  });

  testWidgets('horizontal drag left', (tester) async {
    final horizontal = FResizableBox(
      crossAxisExtent: 50,
      axis: Axis.horizontal,
      interaction: const FResizableInteraction.selectAndResize(0),
      children: [top, bottom],
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(body: Center(child: horizontal)),
      ),
    );

    await tester.timedDrag(find.byType(GestureDetector).at(1), const Offset(-100, 0), const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(tester.getSize(find.byType(FResizable).first), const Size(20, 50));
    expect(tester.getSize(find.byType(FResizable).last), const Size(80, 50));
  });

  testWidgets('horizontal drag when disabled', (tester) async {
    final horizontal = FResizableBox(
      crossAxisExtent: 50,
      axis: Axis.horizontal,
      interaction: const FResizableInteraction.selectAndResize(0),
      children: [top, bottom],
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(body: Center(child: horizontal)),
      ),
    );

    await tester.timedDrag(find.byType(GestureDetector).at(1), const Offset(100, 0), const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(tester.getSize(find.byType(FResizable).first), const Size(80, 50));
    expect(tester.getSize(find.byType(FResizable).last), const Size(20, 50));
  });

  testWidgets('no horizontal drag when disabled', (tester) async {
    final horizontal = FResizableBox(
      crossAxisExtent: 50,
      axis: Axis.horizontal,
      interaction: const FResizableInteraction.selectAndResize(1),
      children: [top, bottom],
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(body: Center(child: horizontal)),
      ),
    );

    await tester.tap(find.byType(GestureDetector).at(3));

    await tester.timedDrag(find.byType(GestureDetector).at(1), const Offset(-100, 0), const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(tester.getSize(find.byType(FResizable).first), const Size(30, 50));
    expect(tester.getSize(find.byType(FResizable).last), const Size(70, 50));
  });
}
