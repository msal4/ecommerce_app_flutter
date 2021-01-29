import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:jewelry_flutter/bloc/location/location_bloc.dart';
import 'package:jewelry_flutter/bloc/product/product_bloc.dart';
import 'package:jewelry_flutter/bloc/profile/profile_bloc.dart';
import 'package:jewelry_flutter/bloc/slider/slider_bloc.dart';
import 'package:jewelry_flutter/bloc/sub_category_product/product_bloc.dart';
import 'package:jewelry_flutter/bloc/theme/theme_cubit.dart';
import 'package:jewelry_flutter/constants.dart';
import 'package:jewelry_flutter/pages/categories.dart';
import 'package:jewelry_flutter/pages/favorites.dart';
import 'package:jewelry_flutter/pages/home.dart';
import 'package:jewelry_flutter/pages/map.dart';
import 'package:jewelry_flutter/pages/profile.dart';
import 'package:jewelry_flutter/pages/settings.dart';

import 'bloc/category/category_bloc.dart';
import 'bloc/favorite/favorite_bloc.dart';
import 'bloc/sub_category/category_bloc.dart';

void main() {
  runApp(
    EasyLocalization(
      supportedLocales: [arabicLocale, englishLocale],
      path: 'assets/translations',
      child: App(),
    ),
  );
}

final introPages = [
  PageViewModel(
    title: "Hello niggers",
    bodyWidget: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text("Click on "),
        Icon(Icons.edit),
        Text(" to edit a post"),
      ],
    ),
    image: const Center(child: Icon(Icons.android)),
  ),
  PageViewModel(
    title: "Hello niggers",
    bodyWidget: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text("Click on "),
        Icon(Icons.edit),
        Text(" to edit a post"),
      ],
    ),
    image: const Center(child: Icon(Icons.android)),
  ),
  PageViewModel(
    title: "Hello niggers",
    bodyWidget: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text("Click on "),
        Icon(Icons.edit),
        Text(" to edit a post"),
      ],
    ),
    image: const Center(child: Icon(Icons.android)),
  ),
];

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => ProductBloc()),
        BlocProvider(create: (_) => SliderBloc()),
        BlocProvider(create: (_) => CategoryBloc()),
        BlocProvider(create: (_) => SubCategoryBloc()),
        BlocProvider(create: (_) => ProfileBloc()),
        BlocProvider(create: (_) => LocationBloc()),
        BlocProvider(create: (_) => FavoriteBloc()),
        BlocProvider(create: (_) => SubCategoryProductBloc()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (_, theme) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            title: 'app_name'.tr(),
            theme: theme.copyWith(
              textTheme: ThemeData.dark().textTheme.apply(
                  fontFamily:
                      context.isArabic ? 'HelveticaNeueArabic' : 'Montserrat'),
            ),
            home: true
                ? RootPage()
                : Builder(
                    builder: (context) {
                      return IntroductionScreen(
                        pages: introPages,
                        showNextButton: true,
                        next: const Text('NEXT'),
                        dotsDecorator:
                            DotsDecorator(activeColor: secondaryColor),
                        done: const Text("GET STARTED",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        onDone: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => RootPage()));
                        },
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _index = 0;

  final _pages = [
    HomePage(),
    CategoriesPage(),
    MapPage(),
    FavoritesPage(),
    ProfilePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final appBarTitle =
        ((_pages[_index] as dynamic).title as String).tr().toUpperCase();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: _index == _pages.length - 1 ? backgroundColor : null,
        centerTitle: true,
        title: Text(
          appBarTitle,
          style: TextStyle(
            fontSize: 13,
            fontFamily: 'Montserrat'.tr(),
            fontWeight: FontWeight.bold,
            letterSpacing: 2.5,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          )
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              spreadRadius: 15,
              blurRadius: 0,
              color: Colors.black.withOpacity(.25),
            )
          ],
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _index,
          onTap: (index) => setState(() => _index = index),
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: buildIcon('home', selected: _index == 0),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: buildIcon('categories', selected: _index == 1),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [secondaryColor, primaryColor],
                  ),
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    shadow(),
                    if (_index == 2)
                      BoxShadow(
                        color: Colors.white.withOpacity(.1),
                        blurRadius: 0,
                        spreadRadius: 10,
                      ),
                  ],
                ),
                child: Center(
                  child: buildIcon('location', selected: true, dot: false),
                ),
              ),
              label: 'Location',
            ),
            BottomNavigationBarItem(
              icon: buildIcon('heart', selected: _index == 3),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: buildIcon('person', selected: _index == 4),
              label: 'About',
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _index,
        children: _pages,
      ),
    );
  }

  buildIcon(String name, {double size = 60, selected = false, dot = true}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/$name.svg',
            width: size,
            height: size,
            fit: BoxFit.cover,
            color: selected ? Colors.white : secondaryTextColor,
          ),
          if (dot)
            Container(
              width: 8,
              height: 8,
              decoration: selected
                  ? BoxDecoration(
                      gradient: gradient,
                      borderRadius: BorderRadius.circular(100),
                    )
                  : null,
            ),
        ],
      );
}
