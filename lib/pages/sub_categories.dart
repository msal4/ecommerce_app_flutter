import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jewelry_flutter/bloc/sub_category/category_bloc.dart';
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
    final id = ModalRoute.of(context).settings.arguments;
    context.bloc<SubCategoryBloc>().add(FetchSubCategories(id: id));
    print('loaded $id');

    return Scaffold(
      appBar: buildAppBar(title: 'CATEGORY'),
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return SubCategoryProductPage();
                        },
                        settings: RouteSettings(arguments: category.idSub)));
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
