import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample.dart';

@RoutePage()
class PopoverPage extends StatefulSample {
  final Axis axis;
  final FHidePopoverRegion hideOnTapOutside;
  final Offset Function(Size, FPortalChildBox, FPortalBox) shift;

  PopoverPage({
    @queryParam String alignment = 'center',
    @queryParam String axis = 'vertical',
    @queryParam String hideOnTapOutside = 'anywhere',
    @queryParam String shift = 'flip',
    @queryParam super.theme,
  }) : axis = switch (axis) {
         'horizontal' => Axis.horizontal,
         _ => Axis.vertical,
       },
       hideOnTapOutside = switch (hideOnTapOutside) {
         'anywhere' => FHidePopoverRegion.anywhere,
         'excludeTarget' => FHidePopoverRegion.excludeTarget,
         _ => FHidePopoverRegion.none,
       },
       shift = switch (shift) {
         'flip' => FPortalShift.flip,
         'along' => FPortalShift.along,
         _ => FPortalShift.none,
       },
       super(
         alignment: switch (alignment) {
           'topCenter' => Alignment.topCenter,
           'bottomCenter' => Alignment.bottomCenter,
           _ => Alignment.center,
         },
         maxHeight: 200,
       );

  @override
  State<PopoverPage> createState() => _State();
}

class _State extends StatefulSampleState<PopoverPage> with SingleTickerProviderStateMixin {
  late FPopoverController controller;

  @override
  void initState() {
    super.initState();
    controller = FPopoverController(vsync: this);
  }

  @override
  Widget sample(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(height: 30),
      FPopover(
        controller: controller,
        popoverAnchor: widget.axis == Axis.horizontal ? Alignment.topLeft : Alignment.topCenter,
        childAnchor: widget.axis == Axis.horizontal ? Alignment.topRight : Alignment.bottomCenter,
        hideOnTapOutside: widget.hideOnTapOutside,
        shift: widget.shift,
        popoverBuilder:
            (context, style, _) => Padding(
              padding: const EdgeInsets.only(left: 20, top: 14, right: 20, bottom: 10),
              child: SizedBox(
                width: 288,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dimensions', style: context.theme.typography.base),
                    const SizedBox(height: 7),
                    Text(
                      'Set the dimensions for the layer.',
                      style: context.theme.typography.sm.copyWith(
                        color: context.theme.colors.mutedForeground,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 15),
                    for (final (label, value) in [
                      ('Width', '100%'),
                      ('Max. Width', '300px'),
                      ('Height', '25px'),
                      ('Max. Height', 'none'),
                    ]) ...[
                      Row(
                        children: [
                          Expanded(child: Text(label, style: context.theme.typography.sm)),
                          Expanded(flex: 2, child: FTextField(initialValue: value)),
                        ],
                      ),
                      const SizedBox(height: 7),
                    ],
                  ],
                ),
              ),
            ),
        child: IntrinsicWidth(
          child: FButton(style: FButtonStyle.outline, onPress: controller.toggle, child: const Text('Open popover')),
        ),
      ),
    ],
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
