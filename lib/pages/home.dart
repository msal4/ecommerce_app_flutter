import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jewelry_flutter/bloc/product/product_bloc.dart';
import 'package:jewelry_flutter/bloc/profile/profile_bloc.dart';
import 'package:jewelry_flutter/bloc/slider/slider_bloc.dart';
import 'package:jewelry_flutter/constants.dart';
import 'package:jewelry_flutter/models/product.dart';
import 'package:jewelry_flutter/models/slider.dart';
import 'package:jewelry_flutter/pages/product.dart';
import 'package:jewelry_flutter/widgets/card.dart' as card;

import '../service.dart';

class HomePage extends StatefulWidget {
  final title = "home";

  @override
  _HomePageState createState() => _HomePageState();
}

enum _ViewMode { grid, list }

class _HomePageState extends State<HomePage> {
  bool _menuVisible = false;
  _ViewMode _viewMode = _ViewMode.list;
  String _show = 'all';
  final _service = Service();

  @override
  void initState() {
    context.read<SliderBloc>().add(FetchSliders());
    context.read<ProductBloc>().add(FetchProducts(show: _show));
    super.initState();
  }

  void getProducts(String show) {
    context.read<ProductBloc>().add(FetchProducts(show: _show));

    setState(() {
      _menuVisible = false;
      _show = show;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.width / 2;
    final sliderHeight = size.width / 1.7;

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
                  return Sliders(slides: state.sliders, height: sliderHeight);
                }

                return SizedBox();
              }),
              Padding(
                padding: const EdgeInsets.only(top: 25, right: 25, left: 25),
                child: Row(
                  crossAxisAlignment: context.isArabic
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _menuVisible = !_menuVisible;
                        });
                      },
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              _show.tr(),
                              style: TextStyle(
                                fontSize: context.isArabic ? 20 : 25,
                                fontFamily: 'BebasNeue'.tr(),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 5),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                size: 20,
                              ),
                            )
                          ],
                        ),
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
                child: Column(
                  children: [
                    RaisedButton.icon(
                      label: Text('RETRY'),
                      onPressed: () {
                        context.read<ProfileBloc>().add(FetchProfile());
                        context.read<SliderBloc>().add(FetchSliders());
                        context
                            .read<ProductBloc>()
                            .add(FetchProducts(show: _show));
                      },
                      icon: Icon(Icons.refresh),
                      color: Colors.black12,
                    ),
                    Text(state.error.message),
                  ],
                ),
              );
            }

            if (state is ProductsLoaded) {
              return Stack(
                children: [
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 100),
                    firstChild: Column(
                      children: [
                        for (int i = 0; i < state.products.length; i++)
                          card.Card(
                            isFavorite: state.products[i].isFavorite,
                            img: state.products[i].images != null &&
                                    state.products[i].images.length > 0
                                ? state.products[i].images[0].imagePath
                                : '',
                            height: height,
                            marginTop: i == 0 ? 25 : 0,
                            onFavoritePressed: () {
                              onFavoritePressed(state.products[i]);
                            },
                            onPressed: () {
                              navigateToProduct(context, state.products[i]);
                            },
                          ),
                      ],
                    ),
                    secondChild: Container(
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

                          return card.GridCard(
                            isFavorite: product.isFavorite,
                            image: product.images != null &&
                                    product.images.length > 0
                                ? product.images[0].imagePath
                                : '',
                            title: product.itemName,
                            subtitle: context.isArabic
                                ? product.categoryName
                                : product.categoryNameEn,
                            onPressed: () {
                              navigateToProduct(context, product);
                            },
                            onFavoritePressed: () {
                              onFavoritePressed(product);
                            },
                          );
                        },
                      ),
                    ),
                    crossFadeState: _viewMode == _ViewMode.list
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 250),
                    top: _menuVisible ? 0 : -200,
                    right: 0,
                    left: 0,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 250),
                      opacity: _menuVisible ? 1 : 0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: horizontalGradient,
                          color: primaryColor,
                        ),
                        child: Column(
                          children: [
                            Container(
                                color: Colors.black.withOpacity(.2),
                                height: 10),
                            buildListTile(
                                text: 'all'.tr().toUpperCase(),
                                selected: _show == 'all',
                                onPressed: () {
                                  getProducts('all');
                                }),
                            buildListTile(
                                text: 'recently'.tr(),
                                selected: _show == 'recently',
                                onPressed: () {
                                  getProducts('recently');
                                }),
                            buildListTile(
                                text: 'most'.tr(),
                                selected: _show == 'most',
                                onPressed: () {
                                  getProducts('most');
                                }),
                          ],
                        ),
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

  void onFavoritePressed(Product product) {
    _service.addFavorite(itemId: product.idItem, itemLikes: product.itemLike);
    product.isFavorite = !product.isFavorite;
    product.likes = product.isFavorite ? product.likes + 1 : product.likes - 1;
    setState(() {});
  }

  void navigateToProduct(BuildContext context, Product product) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => ProductPage(
                onFavorite: () {
                  setState(() {});
                },
              ),
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
          fontFamily: 'BebasNeue'.tr(),
          letterSpacing: 2,
          fontSize: 25,
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
        autoPlayInterval: Duration(seconds: 30),
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
