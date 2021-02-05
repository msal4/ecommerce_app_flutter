import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jewelry_flutter/bloc/theme/theme_cubit.dart';
import 'package:jewelry_flutter/constants.dart';
import 'package:jewelry_flutter/switch.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'settings'.tr().toUpperCase(),
          style: TextStyle(
            fontSize: 13,
            fontFamily: 'BebasNeue'.tr(),
            fontWeight: FontWeight.bold,
            letterSpacing: 2.5,
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            children: [
              // ListTile(
              //   trailing: NadirSwitch(
              //     activeColor: primaryColor,
              //     onChanged: (bool value) {},
              //     value: true,
              //   ),
              //   title: Text(
              //     'push_notifications'.tr().toUpperCase(),
              //     style: TextStyle(
              //       letterSpacing: 3,
              //       fontSize: 18,
              //       fontFamily: 'BebasNeue'.tr(),
              //     ),
              //   ),
              //   subtitle: Text(
              //     'enabled'.tr().toUpperCase(),
              //     style: TextStyle(
              //       letterSpacing: 5,
              //       fontSize: 15,
              //       fontFamily: 'BebasNeue'.tr(),
              //     ),
              //   ),
              // ),
              BlocBuilder<ThemeCubit, ThemeData>(builder: (context, theme) {
                return ListTile(
                  trailing: NadirSwitch(
                    activeColor: primaryColor,
                    onChanged: (bool value) {
                      context.read<ThemeCubit>().toggleTheme(!value);
                    },
                    value: theme.brightness == Brightness.dark,
                  ),
                  title: Text(
                    'appearance'.tr().toUpperCase(),
                    style: TextStyle(
                      letterSpacing: 3,
                      fontSize: 18,
                      fontFamily: 'BebasNeue'.tr(),
                    ),
                  ),
                  subtitle: Text(
                    (theme.brightness == Brightness.dark ? 'dark' : 'light')
                        .tr()
                        .toUpperCase(),
                    style: TextStyle(
                      letterSpacing: 5,
                      fontSize: 15,
                      fontFamily: 'BebasNeue'.tr(),
                    ),
                  ),
                );
              }),
              ListTile(
                onTap: () {
                  context.locale = context.locale == arabicLocale
                      ? englishLocale
                      : arabicLocale;
                },
                title: Text(
                  'language'.tr().toUpperCase(),
                  style: TextStyle(
                    letterSpacing: 3,
                    fontSize: 18,
                    fontFamily: 'BebasNeue'.tr(),
                  ),
                ),
                subtitle: Text(
                  context.locale == arabicLocale ? 'العربية' : 'ENGLISH',
                  style: TextStyle(
                    letterSpacing: 5,
                    fontSize: 15,
                    fontFamily: 'BebasNeue'.tr(),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'rate'.tr().toUpperCase(),
                  style: TextStyle(
                    letterSpacing: 3,
                    fontSize: 18,
                    fontFamily: 'BebasNeue'.tr(),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Text('all_rights_reserved'.tr()),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          'app_name'.tr().toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      Text('®'),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
