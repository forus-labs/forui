import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/sonner/toaster.dart';
import 'package:meta/meta.dart';

/// Displays a toast in a sonner.
///
/// ## Contract
/// Throws [FlutterError] if there is no ancestor [FSonner] in the given [context].
FToast showFToast({
  required BuildContext context,
  required Widget Function(BuildContext context, FToast entry) builder,
  FToastStyle? style,
  FSonnerAlignment alignment = FSonnerAlignment.bottomEnd,
  Duration duration = const Duration(seconds: 5),
  VoidCallback? onDismiss,
}) {
  final state = context.findAncestorStateOfType<FSonnerState>();
  if (state == null) {
    throw FlutterError.fromParts([
      ErrorSummary('showFSonner(...) called with a context that does not contain a FSonner/FScaffold.'),
      ErrorDescription(
        'No FSonner/FScaffold ancestor could be found starting from the context that was passed to FSonner/FScaffold.of(). '
        'This usually happens when the context provided is from the same StatefulWidget as that whose build function '
        'actually creates the FSonner/FScaffold widget being sought.',
      ),
      ErrorHint(
        'There are several ways to avoid this problem. The simplest is to use a Builder to get a '
        'context that is "under" the FSonner/FScaffold.',
      ),
      context.describeElement('The context used was'),
    ]);
  }

  return state.showToast(
    context: context,
    builder: builder,
    style: style,
    alignment: alignment,
    duration: duration,
    onDismiss: onDismiss,
  );
}

/// The sonner's alignment.
enum FSonnerAlignment {
  /// Aligns the sonner to the top start of the screen, depending on the locale's text direction.
  topStart(AlignmentDirectional.topStart, Alignment.bottomCenter),

  /// Aligns the sonner to the start of the screen, depending on the locale's text direction.
  topEnd(AlignmentDirectional.topEnd, Alignment.bottomCenter),

  /// Aligns the sonner to the top left of the screen.
  topLeft(Alignment.topLeft, Alignment.bottomCenter),

  /// Aligns the sonner to the top right of the screen.
  topRight(Alignment.topRight, Alignment.bottomCenter),

  /// Aligns the sonner to the top center of the screen.
  topCenter(Alignment.topCenter, Alignment.bottomCenter),

  /// Aligns the sonner to the bottom start of the screen, depending on the locale's text direction.
  bottomStart(AlignmentDirectional.bottomStart, Alignment.topCenter),

  /// Aligns the sonner to the bottom end of the screen, depending on the locale's text direction.
  bottomEnd(AlignmentDirectional.bottomEnd, Alignment.topCenter),

  /// Aligns the sonner to the bottom left of the screen.
  bottomLeft(Alignment.bottomLeft, Alignment.topCenter),

  /// Aligns the sonner to the bottom right of the screen.
  bottomRight(Alignment.bottomRight, Alignment.topCenter),

  /// Aligns the sonner to the bottom center of the screen.
  bottomCenter(Alignment.bottomCenter, Alignment.topCenter);

  final AlignmentGeometry _alignment;
  final Alignment _toastAlignment;

  const FSonnerAlignment(this._alignment, this._toastAlignment);
}

/// An opinionated toast widget.
///
/// This widget manages a stack of toasts that can be added to using [showFToast]. It should be placed near the root
/// of the widget tree. It is included in [FScaffold] by default.
///
/// See:
/// * https://forui.dev/docs/overlay/sonner for working examples.
/// * [showFToast] for displaying a toast in a sonner.
/// * [FSonnerStyle] for customizing a sonner's appearance.
class FSonner extends StatefulWidget {
  /// The style.
  final FSonnerStyle? style;

  /// The child.
  final Widget child;

  /// Creates a [FSonner] widget.
  const FSonner({required this.child, this.style, super.key});

  @override
  State<FSonner> createState() => FSonnerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

/// A [FSonner]'s state.
class FSonnerState extends State<FSonner> {
  final Map<Alignment, (Alignment, List<ToastEntry>)> _entries = {};

  /// Displays a toast in this sonner.
  ///
  /// It is generally recommend to use [showFToast] instead.
  FToast showToast({
    required BuildContext context,
    required Widget Function(BuildContext context, FToast entry) builder,
    FToastStyle? style,
    FSonnerAlignment alignment = FSonnerAlignment.bottomEnd,
    Duration duration = const Duration(seconds: 5),
    VoidCallback? onDismiss,
  }) {
    final entry = ToastEntry(style, alignment._alignment, duration, builder);
    entry.onDismiss = () {
      entry.dismissing.value = true;
      _remove(entry);
      onDismiss?.call();
    };

    _add(alignment, entry);
    return entry;
  }

  void _add(FSonnerAlignment alignment, ToastEntry entry) {
    if (!mounted) {
      return;
    }

    final FSonnerAlignment(:_alignment, :_toastAlignment) = alignment;
    final resolved = _alignment.resolve(Directionality.maybeOf(context) ?? TextDirection.ltr);
    setState(() {
      final (_, entries) = _entries[resolved] ??= (_toastAlignment, []);
      entries.add(entry);
    });
  }

  void _remove(ToastEntry entry) {
    if (!mounted) {
      return;
    }

    final direction = Directionality.maybeOf(context) ?? TextDirection.ltr;
    if (_entries[entry.alignment.resolve(direction)]?.$2 case final entries?) {
      setState(() => entries.remove(entry));
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? context.theme.sonnerStyle;

    final children = [widget.child];
    for (final MapEntry(key: alignment, value: (toastAlignment, entries)) in _entries.entries) {
      children.add(
        Positioned.fill(
          child: SafeArea(
            child: Padding(
              padding: style.padding,
              child: Align(
                alignment: alignment,
                child: Toaster(
                  expandedAlignTransform: Offset(alignment.x, alignment.y),
                  collapsedAlignTransform: Offset(toastAlignment.x, toastAlignment.y),
                  style: style,
                  entries: entries,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Stack(clipBehavior: Clip.none, fit: StackFit.passthrough, children: children);
  }
}

/// A toast in a sonner.
mixin FToast {
  /// Dismisses the toast. Does nothing if the toast is already being dismissed or dismissed.
  void dismiss();

  /// True if the toast is currently displayed and not being dismissed.
  bool get showing;
}

@internal
class ToastEntry with FToast {
  final GlobalKey key = GlobalKey();
  final FToastStyle? style;
  final AlignmentGeometry alignment;
  final Duration duration;
  final ValueNotifier<bool> dismissing = ValueNotifier(false);
  final Widget Function(BuildContext context, FToast entry) builder;
  VoidCallback? onDismiss;

  ToastEntry(this.style, this.alignment, this.duration, this.builder);

  @override
  void dismiss() {
    if (onDismiss == null || dismissing.value) {
      return;
    }

    dismissing.value = true;
  }

  @override
  bool get showing => onDismiss != null && !dismissing.value;
}
