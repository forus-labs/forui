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
class PaginationSibilingLengthPage extends Sample {
  final FPaginationController controller;

  PaginationSibilingLengthPage({
    @queryParam super.theme,
    @queryParam super.maxWidth = 500,
  }) : controller = FPaginationController(length: 20, siblingLength: 2);

  @override
  Widget sample(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FPagination(
            controller: controller,
          )
        ],
      );
}

@RoutePage()
class PaginationHideFirstLastPage extends Sample {
  final FPaginationController controller;

  PaginationHideFirstLastPage({
    @queryParam super.theme,
  }) : controller = FPaginationController(
          length: 8,
          showFirstLastPages: false,
        );

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
  }) : controller = FPaginationController(length: 10, initialPage: 5);

  // Widget _buildNext() => Padding(
  //       padding: style.itemPadding,
  //       child: FTappable(
  //         focusedOutlineStyle: context.theme.style.focusedOutlineStyle,
  //         onPress: onPress,
  //         builder: (context, tappableData, child) => Container(
  //           decoration: switch (tappableData.hovered) {
  //             (false) => style.unselectedDecoration,
  //             (true) => style.hoveredDecoration,
  //           },
  //           padding: style.contentPadding,
  //           child: ConstrainedBox(
  //             constraints: style.contentConstraints,
  //             child: DefaultTextStyle(
  //               style: style.unselectedTextStyle,
  //               child: Center(child: child!),
  //             ),
  //           ),
  //         ),
  //         child: child,
  //       ),
  //     );

  @override
  Widget sample(BuildContext context) {
    final style = context.theme.paginationStyle;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FPagination(
          controller: controller,
          next: ConstrainedBox(
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
          previous: ConstrainedBox(
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
      ],
    );
  }
}
