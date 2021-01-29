import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelry_flutter/allah.dart';
import 'package:jewelry_flutter/constants.dart';
import 'package:jewelry_flutter/models/product.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../service.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final _carouselController = CarouselController();

  final _service = Service();

  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.width / 1.2;

    final product = ModalRoute.of(context).settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: SvgPicture.asset('assets/svg/logo_bare.svg',
            color: Colors.white, height: kToolbarHeight - 30),
        actions: [
          Row(
            children: [
              Text(
                product.itemLike.toString(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.5,
                ),
              ),
              IconButton(
                color: secondaryColor,
                icon: Icon(Icons.favorite_rounded),
                onPressed: () async {
                  await _service.addFavorite(
                      itemId: product.idItem, itemLikes: product.itemLike);
                },
              ),
            ],
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: height,
            child: Stack(
              children: [
                CarouselSlider(
                  carouselController: _carouselController,
                  options: CarouselOptions(
                      autoPlay: true,
                      viewportFraction: 1,
                      height: double.infinity,
                      onPageChanged: (i, reason) {
                        setState(() {
                          _currentImageIndex = i;
                        });
                      }),
                  items: [
                    for (final img in product.images)
                      PhotoView(
                        tightMode: true,
                        imageProvider: NetworkImage(img.imagePath),
                      ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < product.images.length; i++)
                          GestureDetector(
                            onTap: () {
                              _carouselController.animateToPage(i);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                border: Border.all(color: secondaryColor),
                                borderRadius: BorderRadius.circular(100),
                                gradient: _currentImageIndex == i
                                    ? horizontalGradient
                                    : null,
                              ),
                              width: 15,
                              height: 15,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.itemName,
                  style: TextStyle(
                      fontFamily: 'PlayfairDisplay'.tr(), fontSize: 35),
                ),
                SizedBox(height: 5),
                Text(
                  context.isArabic
                      ? product.categoryName
                      : product.categoryNameEn,
                  style: TextStyle(
                    fontFamily: 'BebasNeue'.tr(),
                    fontSize: 15,
                    letterSpacing: 4,
                    color: secondaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  product.itemDescription,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(.7),
                  ),
                ),
                SizedBox(height: 50),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'gold_caliber'.tr().toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          product.itemQuality.toString(),
                          style: TextStyle(
                            fontFamily: 'PlayfairDisplay',
                            letterSpacing: 2,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'gold_price'.tr().toUpperCase(),
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 5),
                        Text(
                          Application.profile.dollarPrice.toString(),
                          style: TextStyle(
                            fontFamily: 'PlayfairDisplay',
                            letterSpacing: 2,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'weight'.tr().toUpperCase(),
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 5),
                        Text(
                          product.itemQuantity.toString(),
                          style: TextStyle(
                            fontFamily: 'PlayfairDisplay',
                            letterSpacing: 2,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  height: 2,
                  color: Colors.white10,
                  margin: const EdgeInsets.all(30),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryColor, secondaryColor],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      borderRadius: BorderRadius.circular(800),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: InkWell(
                        onTap: () async {
                          launch('tel:${Application.profile.whats}');
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/whatsapp.svg',
                              color: Colors.white,
                              width: 20,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'ORDER NOW',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'BebasNeue',
                                fontSize: 20,
                                letterSpacing: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
