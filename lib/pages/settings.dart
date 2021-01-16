import 'package:flutter/material.dart';
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
      body: ListView(
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
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'BebasNeue',
              ),
            ),
          ),
          ListTile(
            trailing: NadirSwitch(
              activeColor: primaryColor,
              onChanged: (bool value) {},
              value: false,
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
              'LIGHT',
              style: TextStyle(
                letterSpacing: 5,
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'BebasNeue',
              ),
            ),
          ),
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
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'BebasNeue',
              ),
            ),
          )
        ],
      ),
    );
  }
}
