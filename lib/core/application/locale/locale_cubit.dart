import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:handover/core/application/locale/locale_state.dart';
import 'package:injectable/injectable.dart';

const englishLocale = Locale("en");
const arabicLocale = Locale("ar");

@lazySingleton
class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(const LocaleState.initial(locale: englishLocale));

  final List<Locale> supportedLocales =
      List.from([englishLocale, arabicLocale], growable: false);

  /// Side Effect: Emits the current locale
  Future<Locale> getCurrentDeviceLocale() async {
    Locale? locale;
    final currentDeviceLocale = Platform.localeName.split("_").first;
    if (_isCurrentDeviceLocaleSupported(currentDeviceLocale)) {
      locale = Locale.fromSubtags(languageCode: currentDeviceLocale);
    } else {
      locale = englishLocale;
    }

    emit(LocaleState.changed(locale: locale));
    return locale;
  }

  bool _isCurrentDeviceLocaleSupported(String name) {
    if (name == "en" || name == "ar") {
      return true;
    }
    return false;
  }
}
