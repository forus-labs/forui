import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:docs_snippets/example.dart';

@RoutePage()
class PaginationPage extends Example {
  PaginationPage({@queryParam super.theme}) : super(maxWidth: 600);

  @override
  Widget example(BuildContext context) => const FPagination(control: .managed(pages: 10));
}

@RoutePage()
class SiblingsPaginationPage extends Example {
  SiblingsPaginationPage({@queryParam super.theme}) : super(maxWidth: 600);

  @override
  Widget example(BuildContext context) => const FPagination(
    control: .managed(
      pages: 20,
      // {@highlight}
      siblings: 2,
      // {@endhighlight}
      initial: 9,
    ),
  );
}

@RoutePage()
class HideEdgesPaginationPage extends Example {
  HideEdgesPaginationPage({@queryParam super.theme}) : super(maxWidth: 600);

  @override
  Widget example(BuildContext context) => const FPagination(
    control: .managed(
      pages: 8,
      // {@highlight}
      showEdges: false,
      // {@endhighlight}
    ),
  );
}

@RoutePage()
class PaginationCustomIconPage extends StatefulExample {
  PaginationCustomIconPage({@queryParam super.theme}) : super(maxWidth: 400);

  @override
  State<PaginationCustomIconPage> createState() => _PaginationCustomIconPageState();
}

class _PaginationCustomIconPageState extends StatefulExampleState<PaginationCustomIconPage> {
  late final _controller = FPaginationController(pages: 10, page: 4);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget example(BuildContext context) {
    final style = context.theme.paginationStyle;
    return FPagination(
      control: .managed(controller: _controller),
      // {@highlight}
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
      // {@endhighlight}
    );
  }
}

@RoutePage()
class PaginationWithViewPage extends StatefulExample {
  PaginationWithViewPage({@queryParam super.theme}) : super(maxWidth: 400);

  @override
  State<PaginationWithViewPage> createState() => _PaginationWithViewPageState();
}

class _PaginationWithViewPageState extends StatefulExampleState<PaginationWithViewPage> {
  final _controller = PageController();
  final _paginationController = FPaginationController(pages: 10);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _paginationController.value = PageStorage.maybeOf(context)?.readState(context) ?? 0;
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
  Widget example(BuildContext context) {
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
                _paginationController.value = _controller.page!.round();
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
        FPagination(
          control: .managed(controller: _paginationController, onChange: _handlePageChange),
        ),
      ],
    );
  }
}
