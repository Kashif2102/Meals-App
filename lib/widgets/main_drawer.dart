import 'package:flutter/material.dart';
import 'package:meals_app/screens/Filters_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, VoidCallback TapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
      onTap: TapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: <Widget>[
        Container(
          height: 120,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          color: Theme.of(context).accentColor,
          child: Text(
            "Cooking up!",
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).primaryColor),
          ),
        ),
        SizedBox(height: 20),
        buildListTile('Meals', Icons.restaurant, (() {
          Navigator.of(context).pushReplacementNamed('/');
        })),
        buildListTile("Filters", Icons.settings, (() {
          Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          //Push Replacement Named is better than pushNamed here because it does not
          //keep stacking pages on top of each other but replaces the current page
          //which overtime does not cause memory errors due to too many pages in
          //stack
        }))
      ]),
    );
  }
}

//whenever the decoration method is used within a Container, we are required
//to specify the color within the method, otherwise flutter throws an error
