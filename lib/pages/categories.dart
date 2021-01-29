import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jewelry_flutter/bloc/category/category_bloc.dart';
import 'package:jewelry_flutter/constants.dart';
import 'package:jewelry_flutter/pages/sub_categories.dart';
import 'package:jewelry_flutter/widgets/card.dart';

class CategoriesPage extends StatefulWidget {
  final title = "categories";

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  initState() {
    context.bloc<CategoryBloc>().add(FetchCategories());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
      if (state is CategoryLoading) {
        return Center(child: CircularProgressIndicator());
      }

      if (state is CategoryError) {
        return Center(child: Text(state.error.message));
      }

      if (state is CategoriesLoaded) {
        return GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.3,
          padding: const EdgeInsets.all(10),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            for (final category in state.categories)
              GridCard(
                image: category.categoryImage,
                title: context.isArabic
                    ? category.categoryName
                    : category.categoryNameEn,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SubCategoriesPage(),
                      settings: RouteSettings(arguments: category.idCategory),
                    ),
                  );
                },
              )
          ],
        );
      }

      return SizedBox();
    });
  }
}
