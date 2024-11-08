/// Localizations for Forui widgets. Forui supports all 115 languages supported by Material.
///
/// To enable localizations, add `FLocalizations.delegate` in your call to the constructor for `CupertinoApp`,
/// `MaterialApp`, or `WidgetsApp`:
/// ```dart
/// Widget build(BuildContext context) => MaterialApp(
///   localizationsDelegates: [
///     FLocalizations.delegate, // Add this line
///   ],
///   supportedLocales: [
///     // Add locales supported by your application here.
///     // Alternatively, you can pass in `FLocalizations.supportedLocales` instead.
///   ],
///   builder: (context, child) => FTheme(
///     data: FThemes.zinc.light,
///     child: child!,
///   ),
///   home: const FScaffold(...),
/// );
/// ```
library forui.localizations;

export 'src/localizations/localizations.dart';
export 'src/localizations/localization.dart' hide DefaultLocalizations;
