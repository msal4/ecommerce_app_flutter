import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jewelry_flutter/bloc/product/product_bloc.dart';
import 'package:jewelry_flutter/bloc/slider/slider_bloc.dart';
import 'package:jewelry_flutter/constants.dart';
import 'package:jewelry_flutter/models/product.dart';
import 'package:jewelry_flutter/models/slider.dart';
import 'package:jewelry_flutter/pages/product.dart';
import 'package:jewelry_flutter/widgets/card.dart';

class HomePage extends StatefulWidget {
  final title = "HOME";

  @override
  _HomePageState createState() => _HomePageState();
}

enum _ViewMode { grid, list }

class _HomePageState extends State<HomePage> {
  bool _menuVisible = false;
  _ViewMode _viewMode = _ViewMode.list;
  String _show = 'all';
  String _currentShowTitle = 'ALL';

  @override
  void initState() {
    context.bloc<SliderBloc>().add(FetchSliders());
    context.bloc<ProductBloc>().add(FetchProducts(show: _show));
    super.initState();
  }

  void getProducts(String show, String currentTitle) {
    context.bloc<ProductBloc>().add(FetchProducts(show: _show));
    setState(() {
      _currentShowTitle = currentTitle;
      _show = show;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.width / 2;

    return ListView(
      physics: ClampingScrollPhysics(),
      children: [
        Container(
          decoration: BoxDecoration(gradient: gradient),
          width: double.infinity,
          child: Column(
            children: [
              BlocBuilder<SliderBloc, SliderState>(builder: (context, state) {
                if (state is SliderLoading) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 50.0,
                        horizontal: 25,
                      ),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (state is SliderError) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 50.0,
                      horizontal: 25,
                    ),
                    child: Text(state.error.message),
                  );
                }

                if (state is SlidersLoaded) {
                  return Sliders(slides: state.sliders, height: height);
                }

                return SizedBox();
              }),
              Padding(
                padding: const EdgeInsets.only(top: 25, right: 25, left: 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _menuVisible = !_menuVisible;
                        });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            _currentShowTitle,
                            style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'BebasNeue',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            child: IconButton(
                              padding: const EdgeInsets.all(0),
                              icon: Column(
                                children: [
                                  Icon(Icons.view_agenda_outlined),
                                  Spacer(),
                                  if (_viewMode == _ViewMode.list)
                                    Container(
                                      height: 3,
                                      color: Colors.white,
                                    )
                                ],
                              ),
                              onPressed: () {
                                setState(() {
                                  _viewMode = _ViewMode.list;
                                });
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            width: 50,
                            child: IconButton(
                              padding: const EdgeInsets.all(0),
                              icon: Column(
                                children: [
                                  Icon(Icons.grid_view),
                                  Spacer(),
                                  if (_viewMode == _ViewMode.grid)
                                    Container(
                                      height: 3,
                                      color: Colors.white,
                                    )
                                ],
                              ),
                              onPressed: () {
                                setState(() {
                                  _viewMode = _ViewMode.grid;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 50.0, horizontal: 25),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (state is ProductError) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50.0, horizontal: 25),
                child: Text(state.error.message),
              );
            }

            if (state is ProductsLoaded) {
              return Stack(
                children: [
                  if (_viewMode == _ViewMode.list)
                    Column(
                      children: [
                        for (int i = 0; i < state.products.length; i++)
                          Card(
                            img: state.products[i].images != null &&
                                    state.products[i].images.length > 0
                                ? state.products[i].images[0].imagePath
                                : '',
                            height: height,
                            marginTop: i == 0 ? 25 : 0,
                            onPressed: () {
                              navigateToProduct(context, state.products[i]);
                            },
                          ),
                      ],
                    )
                  else
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1 / 1.3,
                          mainAxisSpacing: 25,
                          crossAxisSpacing: 25,
                        ),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];

                          return GridCard(
                            image: product.images != null &&
                                    product.images.length > 0
                                ? product.images[0].imagePath
                                : '',
                            title: product.itemName,
                            subtitle: product.categoryName,
                            onPressed: () {
                              navigateToProduct(context, product);
                            },
                          );
                        },
                      ),
                    ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 250),
                    top: _menuVisible ? 0 : -200,
                    right: 0,
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: horizontalGradient,
                        color: primaryColor,
                      ),
                      child: Column(
                        children: [
                          Container(
                              color: Colors.black.withOpacity(.2), height: 10),
                          buildListTile(
                              text: 'ALL',
                              selected: _show == 'all',
                              onPressed: () {
                                getProducts('all', 'ALL');
                              }),
                          buildListTile(
                              text: 'RECENTLY ADDED',
                              selected: _show == 'recently',
                              onPressed: () {
                                getProducts('recently', 'RECENTLY ADDED');
                              }),
                          buildListTile(
                              text: 'MOST POPULAR',
                              selected: _show == 'most',
                              onPressed: () {
                                getProducts('most', 'MOST POPULAR');
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return SizedBox();
          },
        )
      ],
    );
  }

  void navigateToProduct(BuildContext context, Product product) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => ProductPage(),
          settings: RouteSettings(arguments: product)),
    );
  }

  ListTile buildListTile(
      {text = 'Unknown', selected = false, VoidCallback onPressed}) {
    return ListTile(
      onTap: onPressed,
      selected: selected,
      selectedTileColor: Colors.black.withOpacity(.1),
      contentPadding: const EdgeInsets.symmetric(horizontal: 25),
      title: Text(
        text,
        style: TextStyle(
          color: selected ? Colors.white : Colors.white.withOpacity(.6),
          fontWeight: FontWeight.w500,
          fontFamily: 'BebasNeue',
          letterSpacing: 2,
          fontSize: 25,
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
  }) : super(key: key);

  final String img;
  final double height;
  final double marginTop;
  final VoidCallback onPressed;

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
              child: favoriteBtn(),
            ),
          ],
        ),
      ),
    );
  }
}

class Sliders extends StatelessWidget {
  const Sliders({
    Key key,
    @required this.height,
    @required this.slides,
  }) : super(key: key);

  final double height;
  final List<Slide> slides;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 0.9,
        height: height,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        enlargeCenterPage: true,
      ),
      items: [
        for (final slide in slides)
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(.25),
                  spreadRadius: 1,
                )
              ],
            ),
            margin: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
            child: Image.network(
              slide.sliderImage,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
      ],
    );
  }
}
