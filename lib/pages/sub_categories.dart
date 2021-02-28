import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jewelry_flutter/bloc/sub_category/category_bloc.dart';
import 'package:jewelry_flutter/bloc/sub_category_product/product_bloc.dart';
import 'package:jewelry_flutter/models/category.dart';
import 'package:jewelry_flutter/pages/sub_category_products.dart';
import 'package:jewelry_flutter/widgets/card.dart';

import '../constants.dart';

class SubCategoriesPage extends StatefulWidget {
  @override
  _SubCategoriesPageState createState() => _SubCategoriesPageState();
}

class _SubCategoriesPageState extends State<SubCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    final cat = ModalRoute.of(context).settings.arguments as Category;
    context.bloc<SubCategoryBloc>().add(FetchSubCategories(id: cat.idCategory));

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: Text(
          (context.isArabic ? cat.categoryName : cat.categoryNameEn)
              .toUpperCase(),
          style: TextStyle(
            fontFamily: 'Montserrat'.tr(),
            fontSize: 13,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.5,
          ),
        ),
      ),
      body: BlocBuilder<SubCategoryBloc, CategoryState>(
          builder: (context, state) {
        if (state is CategoryLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is CategoryError) {
          return Center(child: Text(state.error.message));
        }

        if (state is SubCategoriesLoaded) {
          return GridView.count(
            // physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.3,
            padding: const EdgeInsets.all(10),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              for (final category in state.categories)
                GridCard(
                  favorite: false,
                  image: category.subImage,
                  title: category.subName,
                  onPressed: () {
                    context
                        .bloc<SubCategoryProductBloc>()
                        .add(FetchSubCategoryProducts(id: category.idSub));

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return SubCategoryProductPage();
                        },
                        settings: RouteSettings(arguments: category)));
                  },
                )
            ],
          );
        }
        return SizedBox();
      }),
    );
  }
}
