import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class GridCard extends StatelessWidget {
  GridCard({
    @required this.image,
    @required this.title,
    this.subtitle,
    this.onPressed,
    this.favorite = true,
    this.onFavoritePressed,
    this.isFavorite = false,
  });

  final bool favorite;
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;
  final VoidCallback onFavoritePressed;
  final bool isFavorite;

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
                      Color(0xff333333).withOpacity(.7),
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
                          fontFamily: 'PlayfairDisplay'.tr(),
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
            if (favorite)
              Positioned(
                right: 10,
                top: 10,
                child: favoriteBtn(
                    onPressed: onFavoritePressed, isFavorite: isFavorite),
              ),
          ],
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  const Card({
    Key key,
    @required this.img,
    @required this.height,
    this.marginTop = 0,
    this.onPressed,
    this.onFavoritePressed,
    this.isFavorite = false,
  }) : super(key: key);

  final String img;
  final double height;
  final double marginTop;
  final VoidCallback onPressed;
  final VoidCallback onFavoritePressed;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin:
            EdgeInsets.only(left: 25, bottom: 25, right: 25, top: marginTop),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image.network(
                img,
                fit: BoxFit.cover,
                width: double.infinity,
                height: height,
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: favoriteBtn(
                  onPressed: onFavoritePressed, isFavorite: isFavorite),
            ),
          ],
        ),
      ),
    );
  }
}
