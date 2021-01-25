import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jewelry_flutter/bloc/favorite/favorite_bloc.dart';

import '../constants.dart';

class FavoritesPage extends StatefulWidget {
  final title = "FAVORITES";

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    context.bloc<FavoriteBloc>().add(FetchFavorites());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.width / 1.7;

    return BlocBuilder<FavoriteBloc, FavoriteState>(builder: (context, state) {
      if (state is FavoriteLoading) {
        return Center(child: CircularProgressIndicator());
      }

      if (state is FavoriteError) {
        return Center(child: Text(state.error.message));
      }

      if (state is FavoritesLoaded) {
        final favorites = state.favorites;
        print(favorites[0].images[0].imagePath);

        return ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final item = favorites[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 20),
              height: height,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Flexible(
                    child: Image.network(
                      item.images.length > 0 ? item.images[0].imagePath : '',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xff333333),
                          secondarySecondaryColor,
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
                              item.itemName,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'BebasNeue',
                                letterSpacing: 2.5,
                                fontWeight: FontWeight.w500,
                                fontSize: 25,
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
            );
          },
        );
      }
      return SizedBox();
    });
  }
}
