import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class PaginationPage extends Sample {
  static final controllers = {
    'default': FPaginationController(pages: 10),
    'siblings': FPaginationController(pages: 20, siblings: 2, initialPage: 9),
    'hide-edges': FPaginationController(pages: 8, showEdges: false),
  };

  final FPaginationController controller;

  PaginationPage({@queryParam super.theme, @queryParam super.maxWidth = 600, @queryParam String controller = 'default'})
    : controller = controllers[controller]!;

  @override
  Widget sample(BuildContext context) =>
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [FPagination(controller: controller)]);
}

@RoutePage()
class PaginationCustomIconPage extends Sample {
  final FPaginationController controller;

  PaginationCustomIconPage({@queryParam super.theme, @queryParam super.maxWidth = 400})
    : controller = FPaginationController(pages: 10, initialPage: 4);

  @override
  Widget sample(BuildContext context) {
    final style = context.theme.paginationStyle;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FPagination(
          controller: controller,
          next: Padding(
            padding: style.itemPadding,
            child: ConstrainedBox(
              constraints: style.contentConstraints,
              child: FButton.icon(
                style: FButtonStyle.ghost,
                onPress: controller.next,
                child: FIconStyleData(style: style.iconStyle, child: FIcon(FAssets.icons.bird)),
              ),
            ),
          ),
          previous: Padding(
            padding: style.itemPadding,
            child: ConstrainedBox(
              constraints: style.contentConstraints,
              child: FButton.icon(
                style: FButtonStyle.ghost,
                onPress: controller.previous,
                child: FIconStyleData(style: style.iconStyle, child: FIcon(FAssets.icons.anchor)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

@RoutePage()
class PaginationWithViewPage extends StatefulSample {
  PaginationWithViewPage({@queryParam super.theme, @queryParam super.maxWidth = 400});

  @override
  State<PaginationWithViewPage> createState() => _PaginationWithViewPageState();
}

class _PaginationWithViewPageState extends State<PaginationWithViewPage> with SingleTickerProviderStateMixin {
  int pages = 10;
  late PageController controller = PageController();
  late FPaginationController paginationController = FPaginationController(
    pages: pages,
    onPageChanged: _handlePageChanged,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final value = PageStorage.maybeOf(context)?.readState(context) ?? 0;
    paginationController.page = value;
  }

  void _handlePageChanged() {
    if (!controller.hasClients) {
      return;
    }
    final page = paginationController.page;
    final old = controller.page?.round();
    if (old case final old when old != page) {
      if (page == old! + 1 || page == old - 1) {
        setState(() {
          controller.animateToPage(page, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
        });
      } else {
        setState(() {
          controller.jumpToPage(page);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = context.theme.colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        SizedBox(
          height: 300,
          width: 300,
          child: NotificationListener(
            onNotification: (notification) {
              if (notification is ScrollEndNotification) {
                if (controller.hasClients) {
                  paginationController.page = controller.page!.round();
                  return true;
                }
              }
              return false;
            },
            child: PageView.builder(
              itemCount: pages,
              controller: controller,
              itemBuilder:
                  (context, index) => ColoredBox(
                    color: index.isEven ? style.hover(style.primary) : style.mutedForeground,
                    child: Center(
                      child: DefaultTextStyle(
                        style: TextStyle(fontSize: 45, color: style.primaryForeground),
                        child: Text('Page ${index + 1}'),
                      ),
                    ),
                  ),
            ),
          ),
        ),
        FPagination(controller: paginationController),
      ],
    );
  }

  @override
  void dispose() {
    paginationController.dispose();
    controller.dispose();
    super.dispose();
  }
}
