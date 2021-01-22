import 'dart:ui';

import 'package:flutter/material.dart';

import '../constants.dart';

class GridCard extends StatelessWidget {
  GridCard({
    @required this.image,
    @required this.title,
    this.subtitle,
    this.onPressed,
  });

  final String image;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: double.infinity,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Image.network(
              image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xff333333).withOpacity(.3),
                      Theme.of(context).bottomAppBarColor.withOpacity(.3)
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'PlayfairDisplay',
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      if (subtitle != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            subtitle.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              color: secondaryColor,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: favoriteBtn(),
            ),
          ],
        ),
      ),
    );
  }
}
