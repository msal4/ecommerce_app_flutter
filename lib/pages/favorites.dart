import 'package:flutter/material.dart';

import '../constants.dart';

class FavoritesPage extends StatelessWidget {
  final title = "FAVORITES";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.width / 1.7;

    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: 10,
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: height,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Flexible(
              child: Stack(
                children: [
                  Image.network(
                    "http://dashboard.hayderalkhafaje.com/images/J3t3i3I3O3.png",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Positioned(
                    bottom: 15,
                    left: 15,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Text(
                        '4H AGO',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xff333333),
                    Theme.of(context).bottomAppBarColor
                  ],
                ),
              ),
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'BebasNeue',
                          letterSpacing: 2.5,
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          "#GOLD #MSAL #GOD",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                            fontSize: 11,
                            color: secondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Material(
                    borderRadius: BorderRadius.circular(100),
                    clipBehavior: Clip.hardEdge,
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.favorite,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
