import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class PaginationPage extends Sample {
  final FPaginationController controller;

  PaginationPage({
    @queryParam super.theme,
    @queryParam super.maxWidth = 400,
  }) : controller = FPaginationController(length: 10);

  @override
  Widget sample(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [FPagination(controller: controller)],
      );
}

@RoutePage()
class PaginationSiblingsPage extends Sample {
  final FPaginationController controller;

  PaginationSiblingsPage({
    @queryParam super.theme,
    @queryParam super.maxWidth = 500,
  }) : controller = FPaginationController(
          length: 20,
          siblings: 2,
          page: 10,
        );

  @override
  Widget sample(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [FPagination(controller: controller)],
      );
}

@RoutePage()
class PaginationHideFirstLastPage extends Sample {
  final FPaginationController controller;

  PaginationHideFirstLastPage({
    @queryParam super.theme,
  }) : controller = FPaginationController(length: 8, showEdges: false);

  @override
  Widget sample(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [FPagination(controller: controller)],
      );
}

@RoutePage()
class PaginationCustomIconPage extends Sample {
  final FPaginationController controller;

  PaginationCustomIconPage({
    @queryParam super.theme,
    @queryParam super.maxWidth = 400,
  }) : controller = FPaginationController(length: 10, page: 5);

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
                child: FIconStyleData(
                  style: style.iconStyle,
                  child: FIcon(FAssets.icons.bird),
                ),
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
                child: FIconStyleData(
                  style: style.iconStyle,
                  child: FIcon(FAssets.icons.anchor),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
