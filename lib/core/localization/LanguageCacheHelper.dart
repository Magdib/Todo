import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:todoapp/core/constant/HiveData.dart';

class LanguageCacheHelper {
  Future<void> cacheLanguageCode(String languageCode) async {
    final Box dataBox = Hive.box(HiveData.dataBox);
    await dataBox.put(HiveData.locale, languageCode);
  }

  Future<String?> getCachedLanguageCode() async {
    final Box dataBox = Hive.box(HiveData.dataBox);
    final String? cachedLanguage = await dataBox.get(HiveData.locale);
    log("message$cachedLanguage");
    return cachedLanguage;
  }
}
