/// A Flutter package for building beautiful user interfaces.
library forui;

// Icons
export 'package:forui_assets/forui_assets.dart';
export 'package:forui/src/svg_extension.nitrogen.dart';

// Theme
export 'src/theme/color_scheme.dart';
export 'src/theme/style.dart';
export 'src/theme/theme.dart';
export 'src/theme/theme_data.dart';

export 'src/theme/typography.dart';

// Themes
export 'src/theme/themes.dart';

// Widgets
export 'src/widgets/badge/badge.dart' hide FBadgeContent, Variant;
export 'src/foundation/tappable.dart' hide FTappable;
export 'src/widgets/button/button.dart' hide FButtonContent, Variant;
export 'src/widgets/card/card.dart' hide FCardContent;
export 'src/widgets/dialog/dialog.dart' hide FDialogContent, FHorizontalDialogContent, FVerticalDialogContent;
export 'src/widgets/header/header.dart';
export 'src/widgets/separator.dart';
export 'src/widgets/switch.dart';
export 'src/widgets/text_field/text_field.dart';
export 'src/widgets/tabs/tabs.dart';
