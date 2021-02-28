import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jewelry_flutter/bloc/product/product_bloc.dart';
import 'package:jewelry_flutter/bloc/sub_category_product/product_bloc.dart';
import 'package:jewelry_flutter/constants.dart';
import 'package:jewelry_flutter/models/product.dart';
import 'package:jewelry_flutter/models/sub_category.dart';
import 'package:jewelry_flutter/pages/product.dart';
import 'package:jewelry_flutter/widgets/card.dart' as card;

import '../service.dart';

class SubCategoryProductPage extends StatefulWidget {
  @override
  _SubCategoryProductPageState createState() => _SubCategoryProductPageState();
}

class _SubCategoryProductPageState extends State<SubCategoryProductPage> {
  ViewMode _viewMode = ViewMode.list;
  final _service = Service();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.width / 1.7;
    final cat = ModalRoute.of(context).settings.arguments as SubCategory;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: Text(
          (context.isArabic ? cat.subName : cat.subNameEn).toUpperCase(),
          style: TextStyle(
            fontFamily: 'Montserrat'.tr(),
            fontSize: 13,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.5,
          ),
        ),
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Image.network(cat.subImage,
                  height: 200, width: double.infinity, fit: BoxFit.cover),
              Positioned(
                bottom: 0,
                right: 0,
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
                            if (_viewMode == ViewMode.list)
                              Container(
                                height: 3,
                                color: Colors.white,
                              )
                          ],
                        ),
                        onPressed: () {
                          setState(() {
                            _viewMode = ViewMode.list;
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
                            if (_viewMode == ViewMode.grid)
                              Container(
                                height: 3,
                                color: Colors.white,
                              )
                          ],
                        ),
                        onPressed: () {
                          setState(() {
                            _viewMode = ViewMode.grid;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          BlocBuilder<SubCategoryProductBloc, SubCategoryProductState>(
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

              if (state is SubCategoryProductError) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 50.0, horizontal: 25),
                  child: Text(state.error.message),
                );
              }

              if (state is SubCategoryProductsLoaded) {
                if (_viewMode == ViewMode.grid)
                  return Container(
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
                          image: product.images != null &&
                                  product.images.length > 0
                              ? product.images[0].imagePath
                              : '',
                          title: product.itemName,
                          subtitle: product.categoryName,
                          onPressed: () {
                            navigateToProduct(
                                context, Product.fromMap(product.toMap()));
                          },
                          isFavorite: product.isFavorite,
                          onFavoritePressed: () => onFavoritePressed(product),
                        );
                      },
                    ),
                  );
                else {
                  return Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        for (final product in state.products)
                          Container(
                            height: height,
                            margin: const EdgeInsets.only(bottom: 20),
                            child: card.GridCard(
                              image: product.images != null &&
                                      product.images.length > 0
                                  ? product.images[0].imagePath
                                  : '',
                              title: product.itemName,
                              subtitle: product.categoryName,
                              onPressed: () {
                                navigateToProduct(
                                    context, Product.fromMap(product.toMap()));
                              },
                              isFavorite: product.isFavorite,
                              onFavoritePressed: () =>
                                  onFavoritePressed(product),
                            ),
                          )
                      ],
                    ),
                  );
                }
              }
              return SizedBox();
            },
          ),
        ],
      ),
    );
  }

  void navigateToProduct(BuildContext context, Product product) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => ProductPage(),
          settings: RouteSettings(arguments: product)),
    );
  }

  void onFavoritePressed(SubCategoryProduct product) {
    _service.addFavorite(itemId: product.idItem, itemLikes: product.itemLike);
    product.isFavorite = !product.isFavorite;
    product.likes = product.isFavorite ? product.likes + 1 : product.likes - 1;
    setState(() {});
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
