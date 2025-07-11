import 'package:flutter/material.dart';

import 'app_localizations.dart';

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this)!;

  MaterialLocalizations get materialLoc => MaterialLocalizations.of(this);
}
