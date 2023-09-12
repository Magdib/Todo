import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todoapp/Pages/Home/Screen/HomePage.dart';
import 'package:todoapp/Pages/settings/Controllers/LanguageCubit/language_cubit.dart';
import 'package:todoapp/core/localization/AppLocalizations.dart';
import 'package:todoapp/core/localization/LanguageCacheHelper.dart';

class CustomMaterialApp extends StatelessWidget {
  const CustomMaterialApp({
    super.key,
    required this.theme,
  });
  final ThemeData? theme;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageCubit>(
      create: (context) => LanguageCubit()..getSavedLanguage(),
      child: BlocBuilder<LanguageCubit, ChangeLocalState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            home: const HomePage(),
            locale: state.local,
            supportedLocales: const [Locale("en"), Locale("ar")],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              for (var local in supportedLocales) {
                if (deviceLocale != null &&
                    deviceLocale.languageCode == local.languageCode) {
                  state.local = deviceLocale;
                  LanguageCacheHelper()
                      .cacheLanguageCode(deviceLocale.languageCode);
                  return deviceLocale;
                }
              }
              LanguageCacheHelper()
                  .cacheLanguageCode(supportedLocales.first.languageCode);
              return supportedLocales.first;
            },
          );
        },
      ),
    );
  }
}
