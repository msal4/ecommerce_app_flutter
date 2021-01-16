import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jewelry_flutter/bloc/product/product_bloc.dart';
import 'package:jewelry_flutter/bloc/slider/slider_bloc.dart';
import 'package:jewelry_flutter/constants.dart';
import 'package:jewelry_flutter/pages/categories.dart';
import 'package:jewelry_flutter/pages/favorites.dart';
import 'package:jewelry_flutter/pages/home.dart';
import 'package:jewelry_flutter/pages/map.dart';
import 'package:jewelry_flutter/pages/profile.dart';
import 'package:jewelry_flutter/pages/settings.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haydar Alkhafaje',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryColor,
        accentColor: secondaryColor,
        backgroundColor: backgroundColor,
        scaffoldBackgroundColor: backgroundColor,
        fontFamily: 'Montserrat',
      ),
      home: RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _index = 0;

  final List<dynamic> pages = [
    HomePage(),
    CategoriesPage(),
    MapPage(),
    FavoritesPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductBloc()),
        BlocProvider(create: (context) => SliderBloc())
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: _index == pages.length - 1 ? backgroundColor : null,
          centerTitle: true,
          title: Text(
            pages[_index].title,
            style: TextStyle(
              fontSize: 13,
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
        body: pages[_index],
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