import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'locale_state.freezed.dart';

@freezed
class LocaleState with _$LocaleState {
  const factory LocaleState.initial({required Locale locale}) = Initial;

  const factory LocaleState.changed({required Locale locale}) = Changed;
}
