import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/localization/LanguageCacheHelper.dart';
part 'language_state.dart';

class LanguageCubit extends Cubit<ChangeLocalState> {
  LanguageCubit() : super(ChangeLocalState());
  Future<void> getSavedLanguage() async {
    final String? cachedLanguageCode =
        await LanguageCacheHelper().getCachedLanguageCode();
    if (cachedLanguageCode != null) {
      emit(ChangeLocalState(local: Locale(cachedLanguageCode)));
    }
  }

  Future<void> changeLocal() async {
    String? languageCode;
    if (state.local == null) {
      languageCode = await LanguageCacheHelper().getCachedLanguageCode();
    }
    if (state.local == const Locale("ar")) {
      languageCode = "en";
      await LanguageCacheHelper().cacheLanguageCode(languageCode);
      emit(ChangeLocalState(local: Locale(languageCode)));
    } else {
      languageCode = "ar";
      await LanguageCacheHelper().cacheLanguageCode(languageCode);
      emit(ChangeLocalState(local: Locale(languageCode)));
    }
  }
}
