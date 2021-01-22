import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelry_flutter/bloc/profile/profile_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class ProfilePage extends StatefulWidget {
  final title = "PROFILE";

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final appBarColor = Colors.black;

  @override
  void initState() {
    context.bloc<ProfileBloc>().add(FetchProfile());
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
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: SvgPicture.asset(
                'assets/svg/logo.svg',
                height: 50,
                color: secondaryColor,
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: horizontalGradient,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ABOUT US',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    state.profile.aboutUs,
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
                    'CONTACT US',
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
                    onTap: () async {
                      await launch('tel:${state.profile.phoneNumber}');
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
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/svg/snapchat.svg',
                    color: secondaryColor,
                  ),
                  onPressed: () {},
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/svg/whatsapp.svg',
                    color: secondaryColor,
                  ),
                  onPressed: () {},
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/svg/instagram.svg',
                    color: secondaryColor,
                  ),
                  onPressed: () {},
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/svg/facebook.svg',
                    color: secondaryColor,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        );
      }

      return SizedBox();
    });
  }
}
