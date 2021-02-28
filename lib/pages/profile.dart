import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelry_flutter/allah.dart';
import 'package:jewelry_flutter/bloc/profile/profile_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class ProfilePage extends StatefulWidget {
  final title = "profile";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final appBarColor = Colors.black;

  @override
  void initState() {
    context.read<ProfileBloc>().add(FetchProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is ProfileLoading) {
        return Center(child: CircularProgressIndicator());
      }

      if (state is ProfileError) {
        return Center(child: Text(state.error.message));
      }

      if (state is ProfileLoaded) {
        Application.profile = state.profile;

        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: SvgPicture.asset(
                'assets/svg/logo.svg',
                height: 60,
                color: secondaryColor,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: horizontalGradient,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'about_us'.tr(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    context.isArabic
                        ? state.profile.aboutUs
                        : state.profile.aboutUsEn,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'gold_price'.tr(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600,
                      color: secondaryColor,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('\$${state.profile.dollarPrice}'),
                  SizedBox(height: 30),
                  Text(
                    'contact_us'.tr(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600,
                      color: secondaryColor,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 25),
                  ListTile(
                    onTap: () {
                      launch('tel:${state.profile.phoneNumber}');
                    },
                    contentPadding: const EdgeInsets.all(0),
                    leading: Icon(Icons.phone, color: secondaryColor),
                    title: Text(
                      state.profile.phoneNumber,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      await launch('mailto:${state.profile.email}');
                    },
                    contentPadding: const EdgeInsets.all(0),
                    leading: Icon(Icons.mail, color: secondaryColor),
                    title: Text(
                      state.profile.email,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'follow_us_on'.tr(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600,
                      color: secondaryColor,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 70,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/svg/snapchat.svg',
                            color: secondaryColor,
                          ),
                          onPressed: () {
                            launch('https://www.snapchat.com/add/jalkhafaje9');
                          },
                        ),
                        SizedBox(width: 20),
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/svg/whatsapp.svg',
                            color: secondaryColor,
                          ),
                          onPressed: () {
                            FlutterOpenWhatsapp.sendSingleMessage(
                                Application.profile.whats, '');
                          },
                        ),
                        SizedBox(width: 20),
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/svg/instagram.svg',
                            color: secondaryColor,
                          ),
                          onPressed: () {
                            launch(
                                'https://www.instagram.com/jewelry.hayder_alkhafaje/');
                          },
                        ),
                        SizedBox(width: 20),
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/svg/facebook.svg',
                            color: secondaryColor,
                          ),
                          onPressed: () {
                            launch(
                                'https://facebook.com/HayderAlkhafajeJewelry');
                          },
                        ),
                        SizedBox(width: 20),
                        IconButton(
                          iconSize: 40,
                          icon: SvgPicture.asset('assets/svg/youtube.svg',
                              color: secondaryColor),
                          onPressed: () {
                            launch(
                                "https://www.youtube.com/channel/UC4fKH_kihXmKY-7Saeyzg6Q");
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }

      return SizedBox();
    });
  }
}
