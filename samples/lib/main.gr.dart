// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:forui_samples/main.dart' as _i5;
import 'package:forui_samples/widgets/badge.dart' as _i1;
import 'package:forui_samples/widgets/button.dart' as _i2;
import 'package:forui_samples/widgets/card.dart' as _i3;
import 'package:forui_samples/widgets/dialog.dart' as _i4;
import 'package:forui_samples/widgets/header.dart' as _i6;
import 'package:forui_samples/widgets/separator.dart' as _i7;
import 'package:forui_samples/widgets/switch.dart' as _i8;
import 'package:forui_samples/widgets/text_field.dart' as _i9;

abstract class $_AppRouter extends _i10.RootStackRouter {
  $_AppRouter({super.navigatorKey});

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    BadgeRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<BadgeRouteArgs>(
          orElse: () => BadgeRouteArgs(
                theme: queryParams.getString(
                  'theme',
                  'zinc-light',
                ),
                style: queryParams.getString(
                  'style',
                  'primary',
                ),
              ));
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.BadgePage(
          theme: args.theme,
          style: args.style,
        ),
      );
    },
    ButtonIconRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<ButtonIconRouteArgs>(
          orElse: () => ButtonIconRouteArgs(
                theme: queryParams.getString(
                  'theme',
                  'zinc-light',
                ),
                variant: queryParams.getString(
                  'variant',
                  'primary',
                ),
              ));
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.ButtonIconPage(
          theme: args.theme,
          variant: args.variant,
        ),
      );
    },
    ButtonTextRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<ButtonTextRouteArgs>(
          orElse: () => ButtonTextRouteArgs(
                theme: queryParams.getString(
                  'theme',
                  'zinc-light',
                ),
                variant: queryParams.getString(
                  'variant',
                  'primary',
                ),
                label: queryParams.getString(
                  'label',
                  'Button',
                ),
              ));
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.ButtonTextPage(
          theme: args.theme,
          variant: args.variant,
          label: args.label,
        ),
      );
    },
    CardRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<CardRouteArgs>(
          orElse: () => CardRouteArgs(
                  theme: queryParams.getString(
                'theme',
                'zinc-light',
              )));
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.CardPage(theme: args.theme),
      );
    },
    DialogRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<DialogRouteArgs>(
          orElse: () => DialogRouteArgs(
                theme: queryParams.getString(
                  'theme',
                  'zinc-light',
                ),
                vertical: queryParams.getBool(
                  'vertical',
                  false,
                ),
              ));
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.DialogPage(
          theme: args.theme,
          vertical: args.vertical,
        ),
      );
    },
    EmptyRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.EmptyPage(),
      );
    },
    HeaderRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<HeaderRouteArgs>(
          orElse: () => HeaderRouteArgs(
                  theme: queryParams.getString(
                'theme',
                'zinc-light',
              )));
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.HeaderPage(theme: args.theme),
      );
    },
    SeparatorRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<SeparatorRouteArgs>(
          orElse: () => SeparatorRouteArgs(
                  theme: queryParams.getString(
                'theme',
                'zinc-light',
              )));
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.SeparatorPage(theme: args.theme),
      );
    },
    SwitchRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<SwitchRouteArgs>(
          orElse: () => SwitchRouteArgs(
                  theme: queryParams.getString(
                'theme',
                'zinc-light',
              )));
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.SwitchPage(theme: args.theme),
      );
    },
    TextFieldRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<TextFieldRouteArgs>(
          orElse: () => TextFieldRouteArgs(
                theme: queryParams.getString(
                  'theme',
                  'zinc-light',
                ),
                enabled: queryParams.getBool(
                  'enabled',
                  false,
                ),
              ));
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.TextFieldPage(
          theme: args.theme,
          enabled: args.enabled,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.BadgePage]
class BadgeRoute extends _i10.PageRouteInfo<BadgeRouteArgs> {
  BadgeRoute({
    String theme = 'zinc-light',
    String style = 'primary',
    List<_i10.PageRouteInfo>? children,
  }) : super(
          BadgeRoute.name,
          args: BadgeRouteArgs(
            theme: theme,
            style: style,
          ),
          rawQueryParams: {
            'theme': theme,
            'style': style,
          },
          initialChildren: children,
        );

  static const String name = 'BadgeRoute';

  static const _i10.PageInfo<BadgeRouteArgs> page =
      _i10.PageInfo<BadgeRouteArgs>(name);
}

class BadgeRouteArgs {
  const BadgeRouteArgs({
    this.theme = 'zinc-light',
    this.style = 'primary',
  });

  final String theme;

  final String style;

  @override
  String toString() {
    return 'BadgeRouteArgs{theme: $theme, style: $style}';
  }
}

/// generated route for
/// [_i2.ButtonIconPage]
class ButtonIconRoute extends _i10.PageRouteInfo<ButtonIconRouteArgs> {
  ButtonIconRoute({
    String theme = 'zinc-light',
    String variant = 'primary',
    List<_i10.PageRouteInfo>? children,
  }) : super(
          ButtonIconRoute.name,
          args: ButtonIconRouteArgs(
            theme: theme,
            variant: variant,
          ),
          rawQueryParams: {
            'theme': theme,
            'variant': variant,
          },
          initialChildren: children,
        );

  static const String name = 'ButtonIconRoute';

  static const _i10.PageInfo<ButtonIconRouteArgs> page =
      _i10.PageInfo<ButtonIconRouteArgs>(name);
}

class ButtonIconRouteArgs {
  const ButtonIconRouteArgs({
    this.theme = 'zinc-light',
    this.variant = 'primary',
  });

  final String theme;

  final String variant;

  @override
  String toString() {
    return 'ButtonIconRouteArgs{theme: $theme, variant: $variant}';
  }
}

/// generated route for
/// [_i2.ButtonTextPage]
class ButtonTextRoute extends _i10.PageRouteInfo<ButtonTextRouteArgs> {
  ButtonTextRoute({
    String theme = 'zinc-light',
    String variant = 'primary',
    String label = 'Button',
    List<_i10.PageRouteInfo>? children,
  }) : super(
          ButtonTextRoute.name,
          args: ButtonTextRouteArgs(
            theme: theme,
            variant: variant,
            label: label,
          ),
          rawQueryParams: {
            'theme': theme,
            'variant': variant,
            'label': label,
          },
          initialChildren: children,
        );

  static const String name = 'ButtonTextRoute';

  static const _i10.PageInfo<ButtonTextRouteArgs> page =
      _i10.PageInfo<ButtonTextRouteArgs>(name);
}

class ButtonTextRouteArgs {
  const ButtonTextRouteArgs({
    this.theme = 'zinc-light',
    this.variant = 'primary',
    this.label = 'Button',
  });

  final String theme;

  final String variant;

  final String label;

  @override
  String toString() {
    return 'ButtonTextRouteArgs{theme: $theme, variant: $variant, label: $label}';
  }
}

/// generated route for
/// [_i3.CardPage]
class CardRoute extends _i10.PageRouteInfo<CardRouteArgs> {
  CardRoute({
    String theme = 'zinc-light',
    List<_i10.PageRouteInfo>? children,
  }) : super(
          CardRoute.name,
          args: CardRouteArgs(theme: theme),
          rawQueryParams: {'theme': theme},
          initialChildren: children,
        );

  static const String name = 'CardRoute';

  static const _i10.PageInfo<CardRouteArgs> page =
      _i10.PageInfo<CardRouteArgs>(name);
}

class CardRouteArgs {
  const CardRouteArgs({this.theme = 'zinc-light'});

  final String theme;

  @override
  String toString() {
    return 'CardRouteArgs{theme: $theme}';
  }
}

/// generated route for
/// [_i4.DialogPage]
class DialogRoute extends _i10.PageRouteInfo<DialogRouteArgs> {
  DialogRoute({
    String theme = 'zinc-light',
    bool vertical = false,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          DialogRoute.name,
          args: DialogRouteArgs(
            theme: theme,
            vertical: vertical,
          ),
          rawQueryParams: {
            'theme': theme,
            'vertical': vertical,
          },
          initialChildren: children,
        );

  static const String name = 'DialogRoute';

  static const _i10.PageInfo<DialogRouteArgs> page =
      _i10.PageInfo<DialogRouteArgs>(name);
}

class DialogRouteArgs {
  const DialogRouteArgs({
    this.theme = 'zinc-light',
    this.vertical = false,
  });

  final String theme;

  final bool vertical;

  @override
  String toString() {
    return 'DialogRouteArgs{theme: $theme, vertical: $vertical}';
  }
}

/// generated route for
/// [_i5.EmptyPage]
class EmptyRoute extends _i10.PageRouteInfo<void> {
  const EmptyRoute({List<_i10.PageRouteInfo>? children})
      : super(
          EmptyRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmptyRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i6.HeaderPage]
class HeaderRoute extends _i10.PageRouteInfo<HeaderRouteArgs> {
  HeaderRoute({
    String theme = 'zinc-light',
    List<_i10.PageRouteInfo>? children,
  }) : super(
          HeaderRoute.name,
          args: HeaderRouteArgs(theme: theme),
          rawQueryParams: {'theme': theme},
          initialChildren: children,
        );

  static const String name = 'HeaderRoute';

  static const _i10.PageInfo<HeaderRouteArgs> page =
      _i10.PageInfo<HeaderRouteArgs>(name);
}

class HeaderRouteArgs {
  const HeaderRouteArgs({this.theme = 'zinc-light'});

  final String theme;

  @override
  String toString() {
    return 'HeaderRouteArgs{theme: $theme}';
  }
}

/// generated route for
/// [_i7.SeparatorPage]
class SeparatorRoute extends _i10.PageRouteInfo<SeparatorRouteArgs> {
  SeparatorRoute({
    String theme = 'zinc-light',
    List<_i10.PageRouteInfo>? children,
  }) : super(
          SeparatorRoute.name,
          args: SeparatorRouteArgs(theme: theme),
          rawQueryParams: {'theme': theme},
          initialChildren: children,
        );

  static const String name = 'SeparatorRoute';

  static const _i10.PageInfo<SeparatorRouteArgs> page =
      _i10.PageInfo<SeparatorRouteArgs>(name);
}

class SeparatorRouteArgs {
  const SeparatorRouteArgs({this.theme = 'zinc-light'});

  final String theme;

  @override
  String toString() {
    return 'SeparatorRouteArgs{theme: $theme}';
  }
}

/// generated route for
/// [_i8.SwitchPage]
class SwitchRoute extends _i10.PageRouteInfo<SwitchRouteArgs> {
  SwitchRoute({
    String theme = 'zinc-light',
    List<_i10.PageRouteInfo>? children,
  }) : super(
          SwitchRoute.name,
          args: SwitchRouteArgs(theme: theme),
          rawQueryParams: {'theme': theme},
          initialChildren: children,
        );

  static const String name = 'SwitchRoute';

  static const _i10.PageInfo<SwitchRouteArgs> page =
      _i10.PageInfo<SwitchRouteArgs>(name);
}

class SwitchRouteArgs {
  const SwitchRouteArgs({this.theme = 'zinc-light'});

  final String theme;

  @override
  String toString() {
    return 'SwitchRouteArgs{theme: $theme}';
  }
}

/// generated route for
/// [_i9.TextFieldPage]
class TextFieldRoute extends _i10.PageRouteInfo<TextFieldRouteArgs> {
  TextFieldRoute({
    String theme = 'zinc-light',
    bool enabled = false,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          TextFieldRoute.name,
          args: TextFieldRouteArgs(
            theme: theme,
            enabled: enabled,
          ),
          rawQueryParams: {
            'theme': theme,
            'enabled': enabled,
          },
          initialChildren: children,
        );

  static const String name = 'TextFieldRoute';

  static const _i10.PageInfo<TextFieldRouteArgs> page =
      _i10.PageInfo<TextFieldRouteArgs>(name);
}

class TextFieldRouteArgs {
  const TextFieldRouteArgs({
    this.theme = 'zinc-light',
    this.enabled = false,
  });

  final String theme;

  final bool enabled;

  @override
  String toString() {
    return 'TextFieldRouteArgs{theme: $theme, enabled: $enabled}';
  }
}
