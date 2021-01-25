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
          'SETTINGS',
          style: TextStyle(
            fontSize: 13,
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
              ListTile(
                trailing: NadirSwitch(
                  activeColor: primaryColor,
                  onChanged: (bool value) {},
                  value: true,
                ),
                title: Text(
                  'PUSH NOTIFICATIONS',
                  style: TextStyle(
                    letterSpacing: 3,
                    fontSize: 18,
                    fontFamily: 'BebasNeue',
                  ),
                ),
                subtitle: Text(
                  'ENABLED',
                  style: TextStyle(
                    letterSpacing: 5,
                    fontSize: 15,
                    fontFamily: 'BebasNeue',
                  ),
                ),
              ),
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
                    'APPEARANCE',
                    style: TextStyle(
                      letterSpacing: 3,
                      fontSize: 18,
                      fontFamily: 'BebasNeue',
                    ),
                  ),
                  subtitle: Text(
                    theme.brightness == Brightness.dark ? 'DARK' : 'LIGHT',
                    style: TextStyle(
                      letterSpacing: 5,
                      fontSize: 15,
                      fontFamily: 'BebasNeue',
                    ),
                  ),
                );
              }),
              ListTile(
                title: Text(
                  'LANGUAGE',
                  style: TextStyle(
                    letterSpacing: 3,
                    fontSize: 18,
                    fontFamily: 'BebasNeue',
                  ),
                ),
                subtitle: Text(
                  'ENGLISH',
                  style: TextStyle(
                    letterSpacing: 5,
                    fontSize: 15,
                    fontFamily: 'BebasNeue',
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'RATE',
                  style: TextStyle(
                    letterSpacing: 3,
                    fontSize: 18,
                    fontFamily: 'BebasNeue',
                  ),
                ),
                subtitle: Text(
                  'ENGLISH',
                  style: TextStyle(
                    letterSpacing: 5,
                    fontSize: 15,
                    fontFamily: 'BebasNeue',
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
                  Text('All Rights Reserved'),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          'Hayder Alkhafaje'.toUpperCase(),
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
