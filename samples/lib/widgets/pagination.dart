import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class PaginationPage extends StatefulSample {
  final String controller;

  PaginationPage({@queryParam super.theme, @queryParam super.maxWidth = 600, @queryParam this.controller = 'default'});

  @override
  State<PaginationPage> createState() => _PaginationPageState();
}

class _PaginationPageState extends StatefulSampleState<PaginationPage> {
  late FPaginationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = _updateController(widget.controller);
  }

  @override
  void didUpdateWidget(covariant PaginationPage old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller) {
      _controller.dispose();
      _controller = _updateController(widget.controller);
    }
  }

  FPaginationController _updateController(String controller) {
    switch (controller) {
      case 'siblings':
        return FPaginationController(pages: 20, siblings: 2, initialPage: 9);
      case 'hide-edges':
        return FPaginationController(pages: 8, showEdges: false);
      default:
        return FPaginationController(pages: 10);
    }
  }

  @override
  Widget sample(BuildContext context) =>
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [FPagination(controller: _controller)]);
}

@RoutePage()
class PaginationCustomIconPage extends StatefulSample {
  PaginationCustomIconPage({@queryParam super.theme, @queryParam super.maxWidth = 400});

  @override
  State<PaginationCustomIconPage> createState() => _PaginationCustomIconPageState();
}

class _PaginationCustomIconPageState extends StatefulSampleState<PaginationCustomIconPage> {
  late final FPaginationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FPaginationController(pages: 10, initialPage: 4);
  }

  @override
  Widget sample(BuildContext context) {
    final style = context.theme.paginationStyle;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FPagination(
          controller: _controller,
          next: Padding(
            padding: style.itemPadding,
            child: ConstrainedBox(
              constraints: style.itemConstraints,
              child: FButton.icon(
                style: FButtonStyle.ghost,
                onPress: _controller.next,
                child: IconTheme(data: style.itemIconStyle.resolve({}), child: const Icon(FIcons.bird)),
              ),
            ),
          ),
          previous: Padding(
            padding: style.itemPadding,
            child: ConstrainedBox(
              constraints: style.itemConstraints,
              child: FButton.icon(
                style: FButtonStyle.ghost,
                onPress: _controller.previous,
                child: IconTheme(data: style.itemIconStyle.resolve({}), child: const Icon(FIcons.anchor)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

@RoutePage()
class PaginationWithViewPage extends StatefulSample {
  PaginationWithViewPage({@queryParam super.theme, @queryParam super.maxWidth = 400});

  @override
  State<PaginationWithViewPage> createState() => _PaginationWithViewPageState();
}

class _PaginationWithViewPageState extends StatefulSampleState<PaginationWithViewPage> {
  int pages = 10;
  late PageController controller = PageController();
  late FPaginationController paginationController = FPaginationController(pages: pages);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final value = PageStorage.maybeOf(context)?.readState(context) ?? 0;
    paginationController.page = value;
  }

  void _handlePageChange() {
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
  Widget sample(BuildContext context) {
    final colors = context.theme.colors;
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
                    color: index.isEven ? colors.hover(colors.primary) : colors.mutedForeground,
                    child: Center(
                      child: DefaultTextStyle(
                        style: TextStyle(fontSize: 45, color: colors.primaryForeground),
                        child: Text('Page ${index + 1}'),
                      ),
                    ),
                  ),
            ),
          ),
        ),
        FPagination(controller: paginationController, onChange: _handlePageChange),
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
