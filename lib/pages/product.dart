import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jewelry_flutter/constants.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
];

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final _carouselController = CarouselController();

  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.width / 1.2;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'PRODUCT',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.5,
          ),
        ),
        actions: [
          Row(
            children: [
              Text(
                '120',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.5,
                ),
              ),
              IconButton(
                color: secondaryColor,
                icon: Icon(Icons.favorite_rounded),
                onPressed: () {},
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
                    for (final img in imgList)
                      Image.network(
                        img,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
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
                        for (int i = 0; i < imgList.length; i++)
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
                  'Immanuel',
                  style: TextStyle(fontFamily: 'PlayfairDisplay', fontSize: 35),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'PHOTOGRAPHY',
                      style: TextStyle(
                        fontFamily: 'BebasNeue',
                        fontSize: 15,
                        letterSpacing: 4,
                        color: secondaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '7 OCT, 2017',
                      style: TextStyle(
                        fontFamily: 'BebasNeue',
                        color: Colors.white.withOpacity(.5),
                        fontSize: 15,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  '''.supmet eitselom des alugil ,murtur cenoD .ucra teeroal susruc ,di sore ue sisilicaf ,tse euqen maN
.otsuj susruc des siuD .sucal tege euqitsirt ,di ainical tege susruc ,mauq rolod nI .repmes mudnebib tirerdneh deS .sore eitselom eativ naeneA''',
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
                          'CAMERA',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Nikon D90',
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
                          'CAMERA',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Nikon D90',
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
                        onTap: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.whatshot),
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
