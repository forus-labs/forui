import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:auto_route/auto_route.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class PaginationPage extends StatefulSample {
  final String controller;

  PaginationPage({@queryParam super.theme, @queryParam super.maxWidth = 600, @queryParam this.controller = 'default'});

  @override
  State<PaginationPage> createState() => _PaginationPageState();
}

class _PaginationPageState extends StatefulSampleState<PaginationPage> {
  late FPaginationController _controller = _updateController(widget.controller);

  @override
  void didUpdateWidget(covariant PaginationPage old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller) {
      _controller.dispose();
      _controller = _updateController(widget.controller);
    }
  }

  FPaginationController _updateController(String controller) => switch (controller) {
    'siblings' => FPaginationController(pages: 20, siblings: 2, initialPage: 9),
    'hide-edges' => FPaginationController(pages: 8, showEdges: false),
    _ => FPaginationController(pages: 10),
  };

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => Column(
    mainAxisAlignment: .center,
    children: [FPagination(controller: _controller)],
  );
}

@RoutePage()
class PaginationCustomIconPage extends StatefulSample {
  PaginationCustomIconPage({@queryParam super.theme, @queryParam super.maxWidth = 400});

  @override
  State<PaginationCustomIconPage> createState() => _PaginationCustomIconPageState();
}



class _PaginationCustomIconPageState extends StatefulSampleState<PaginationCustomIconPage> {
  late final _controller = FPaginationController(pages: 10, initialPage: 4);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) {
    final style = context.theme.paginationStyle;
    return Column(
      mainAxisAlignment: .center,
      children: [
        FPagination(
          controller: _controller,
          next: Padding(
            padding: style.itemPadding,
            child: ConstrainedBox(
              constraints: style.itemConstraints,
              child: FButton.icon(
                style: FButtonStyle.ghost(),
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
                style: FButtonStyle.ghost(),
                onPress: _controller.previous,
                child: IconTheme(data: style.itemIconStyle.resolve({}), child: const Icon(FIcons.anchor)),
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



class _PaginationWithViewPageState extends StatefulSampleState<PaginationWithViewPage> {
  final _controller = PageController();
  final _paginationController = FPaginationController(pages: 10);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _paginationController.page = PageStorage.maybeOf(context)?.readState(context) ?? 0;
  }

  void _handlePageChange(int page) {
    final old = _controller.page?.round();
    if (old case final old when old != page) {
      if (page == old! + 1 || page == old - 1) {
        setState(() {
          _controller.animateToPage(page, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
        });
      } else {
        setState(() {
          _controller.jumpToPage(page);
        });
      }
    }
  }

  @override
  void dispose() {
    _paginationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) {
    final colors = context.theme.colors;
    return Column(
      mainAxisSize: .min,
      mainAxisAlignment: .center,
      spacing: 10,
      children: [
        SizedBox(
          height: 300,
          width: 300,
          child: NotificationListener<ScrollEndNotification>(
            onNotification: (notification) {
              if (_controller.hasClients) {
                _paginationController.page = _controller.page!.round();
                return true;
              }

              return false;
            },
            child: PageView.builder(
              itemCount: 10,
              controller: _controller,
              itemBuilder: (context, index) => ColoredBox(
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
        FPagination(controller: _paginationController, onChange: _handlePageChange),
      ],
    );
  }
}
