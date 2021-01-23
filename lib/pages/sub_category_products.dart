import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jewelry_flutter/bloc/product/product_bloc.dart';
import 'package:jewelry_flutter/bloc/sub_category_product/product_bloc.dart';
import 'package:jewelry_flutter/constants.dart';
import 'package:jewelry_flutter/models/product.dart';
import 'package:jewelry_flutter/pages/product.dart';
import 'package:jewelry_flutter/widgets/card.dart' as card;

class SubCategoryProductPage extends StatefulWidget {
  @override
  _SubCategoryProductPageState createState() => _SubCategoryProductPageState();
}

class _SubCategoryProductPageState extends State<SubCategoryProductPage> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as int;

    context
        .bloc<SubCategoryProductBloc>()
        .add(FetchSubCategoryProducts(id: id));

    return Scaffold(
      appBar: buildAppBar(title: 'CATEGORY'),
      body: BlocBuilder<SubCategoryProductBloc, SubCategoryProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50.0, horizontal: 25),
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is SubCategoryProductError) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 50.0, horizontal: 25),
              child: Text(state.error.message),
            );
          }

          if (state is SubCategoryProductsLoaded) {
            return Stack(
              children: [
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

                      return card.GridCard(
                        image:
                            product.images != null && product.images.length > 0
                                ? product.images[0].imagePath
                                : '',
                        title: product.itemName,
                        subtitle: product.categoryName,
                        onPressed: () {
                          navigateToProduct(
                              context, Product.fromMap(product.toMap()));
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return SizedBox();
        },
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
