import 'package:flutter/material.dart';

import '../Models/Meal.dart';

import '../widgets/main_drawer.dart';

import '../screens/Categories_screen.dart';
import '../screens/Favorites_screen.dart';

class TabsScreen extends StatefulWidget {
  List<Meal> _favourites;

  TabsScreen(this._favourites);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
//You cannot use "widget. " outside Widget build()
//but "widget. " is available inside init - so we use init

  late List<Map<String, Object>> _pages;

  @override
  void initState() {
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {'page': FavoritesScreen(widget._favourites), 'title': 'Your Favorites'},
    ];
    super.initState();
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex:
            0, //0 by default, decides which Tab selection is the default one
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(_pages[_selectedPageIndex]['title'] as String),
          ),
          drawer: MainDrawer(),
          body: _pages[_selectedPageIndex]['page'] as Widget,
          bottomNavigationBar: BottomNavigationBar(
            onTap: _selectPage,
            unselectedItemColor: Colors.white,
            selectedItemColor: Theme.of(context).accentColor,
            backgroundColor: Theme.of(context).primaryColor,
            type: BottomNavigationBarType.shifting,
            currentIndex: _selectedPageIndex,
            // selectedFontSize: 15,
            // unselectedFontSize: 15,
            //This is for when we don't want changes in selected and unselected fonts
            //in our BottomNavigationBar
            items: [
              BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).primaryColor,
                  icon: Icon(Icons.category),
                  label: "Categories"),
              BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).primaryColor,
                  icon: Icon(Icons.star),
                  label: "Favorites")
            ],
          ),
        ));
  }
}






//This is the first method of implementing TabBar

// class _TabsScreenState extends State<TabsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//         initialIndex:
//             0, //0 by default, decides which Tab selection is the default one
//         length: 2,
//         child: Scaffold(
//             appBar: AppBar(
//                 title: Text("Meals"),
//                 bottom: TabBar(
//                   tabs: <Widget>[
//                     Tab(icon: Icon(Icons.category), text: "Categories"),
//                     Tab(icon: Icon(Icons.star), text: "Favorites")
//                   ],
//                 )),
//             body: TabBarView(
//                 children: <Widget>[CategoriesScreen(), FavoritesScreen()])));
//   }
// }