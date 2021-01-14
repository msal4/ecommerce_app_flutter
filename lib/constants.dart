import 'package:flutter/material.dart';

const primaryColor = Color(0xffa46e50);
const secondaryColor = Color(0xffd7ab72);
const backgroundColor = Color(0xff111111);
const secondaryTextColor = Color(0xff888888);

const gradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [primaryColor, secondaryColor],
);
const horizontalGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [primaryColor, secondaryColor],
);

shadow() => BoxShadow(
      color: Colors.black.withOpacity(.15),
      blurRadius: 15,
      offset: const Offset(0.0, 20),
    );

favoriteBtn() => Container(
      decoration: BoxDecoration(boxShadow: [shadow()]),
      child: Material(
        borderRadius: BorderRadius.circular(100),
        clipBehavior: Clip.hardEdge,
        color: Colors.white,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              Icons.favorite_border,
              color: primaryColor,
            ),
          ),
        ),
      ),
    );
