
import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

void main() {
  runApp(const Application());
}

/// The application widget.
class Application extends StatelessWidget {
  /// Creates an application widget.
  const Application({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: FTheme(
          data: FThemes.zinc.light,
          child: Scaffold(
            backgroundColor: FThemes.zinc.light.colorScheme.background,
            body: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ExampleWidget(),
              ],
            ),
          ),
        ),
      );
}

class ExampleWidget extends StatefulWidget {
  const ExampleWidget({super.key});

  @override
  State<ExampleWidget> createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {

  @override
  void initState() {
    super.initState();
  }

  Widget _dialog(BuildContext context) {
    final style = context.theme.cardStyle;
    final contentStyle = style.content;
    final typography = context.theme.typography;
    final effectivePadding =
        MediaQuery.viewInsetsOf(context) + const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0);

    final child = Align(
      child: DefaultTextStyle(
        style: context.theme.typography.toTextStyle(
          fontSize: typography.base,
          color: context.theme.colorScheme.foreground,
        ),
        child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 280.0),
            child: DecoratedBox(
              decoration: style.decoration,
              child: Padding(
                padding: style.content.padding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Are you absolutely sure?', style: contentStyle.title.scale(typography)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
                        style: contentStyle.subtitle.scale(typography), textAlign: TextAlign.center,),
                    SizedBox(
                      height: 18,
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        // Get the width of the screen
                        final screenWidth = MediaQuery.sizeOf(context).width;

                        // Calculate the combined width of the buttons
                        final buttonWidth = constraints.maxWidth;

                        print(screenWidth);
                        print(buttonWidth);

                        // If the combined width of the buttons exceeds the screen width, place them in a Column
                        if (true) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 7.0),
                                child: FButton(text: 'Continue', onPress: () {}),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 7.0),
                                child: FButton(design: FButtonVariant.outlined, text: 'Cancel', onPress: () {}),
                              ),
                            ],
                          );
                        } else {
                          // Otherwise, place them in a Row
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                                  child: FButton(design: FButtonVariant.outlined, text: 'Cancel', onPress: () {}),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                                  child: FButton(text: 'Continue', onPress: () {}),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            )),
      ),
    );

    return AnimatedPadding(
      padding: effectivePadding,
      duration: const Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          FButton(
            design: FButtonVariant.destructive,
            text: 'Delete?',
            onPress: () => showAdaptiveDialog(
              context: context,
              builder: (context) => FDialog(
                alignment: FDialogAlignment.horizontal,
                title: 'Are you absolutely sure?',
                subtitle: 'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
                actions: [
                  FButton(design: FButtonVariant.outlined, text: 'Cancel', onPress: () {
                    Navigator.of(context).pop();
                  }),
                  FButton(text: 'Continue', onPress: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
}
