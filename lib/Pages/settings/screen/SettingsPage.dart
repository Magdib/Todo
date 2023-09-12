import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/Pages/settings/Controllers/LanguageCubit/language_cubit.dart';
import 'package:todoapp/Pages/settings/Data/getSettingsList.dart';
import 'package:todoapp/core/constant/AppColors.dart';
import 'package:todoapp/core/Helper/AppHelper.dart';
import 'package:todoapp/core/localization/AppLocalizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              "Settings Page".tr(context),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: AppColors.white),
            ),
            centerTitle: true),
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 120,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: getSettingsList(context).length,
            padding: EdgeInsets.symmetric(
                vertical: AppHelper.getDeviceHeight(context) / 4,
                horizontal: 40),
            itemBuilder: (context, index) => MaterialButton(
                  onPressed: index == 0
                      ? () => context.read<LanguageCubit>().changeLocal()
                      : getSettingsList(context)[index]["function"],
                  color: AppColors.white,
                  disabledColor: AppColors.veryLightGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        getSettingsList(context)[index]['text'],
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Icon(
                        getSettingsList(context)[index]['icon'],
                        color: Theme.of(context).primaryColor,
                        size: 35,
                      )
                    ],
                  ),
                )));
  }
}
