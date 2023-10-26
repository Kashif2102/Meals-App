import 'package:flutter/material.dart';
import './Dummy_data.dart';
import './Models/Meal.dart';

import './screens/Category_Meals_Screen.dart';
import './screens/Filters_screen.dart';
import './screens/meal_detail_screen.dart';
import './widgets/Tabs_screen.dart';

import './screens/Categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;

  void _setFilters(Map<String, bool> filterdata) {
    setState(() {
      _filters = filterdata;

//the "?? false" specifies that if no value exists,
//just take false as the value

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        return true;

        //throw(false); does this work? -> this works when you just
        //want to execute the code and doesn't guarantee anything proper.
      }).toList();
    });
  }

  List<Meal> _favouritedMeals = [];

  // .indexWhere returns the index of the list memeber which satisfies
  //the specified function, if no such member exists
  //it returns -1.

  void _togglefavorite(String mealId) {
    final existingindex = _favouritedMeals.indexWhere((m) => m.id == mealId);

    if (existingindex >= 0) {
      _favouritedMeals.removeAt(existingindex);
    } else {
      _favouritedMeals.add(DUMMY_MEALS.firstWhere((m) => m.id == mealId));
    }
  }

  bool isMealFavourite(String id) {
    return _favouritedMeals.any((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.greenAccent,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              headline6: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold))),
      //This tells our app which screen is the home screen,
      //which screen to load first
      //home: CategoriesScreen();
      //initialRoute: "this is used to change default home screen key from '/' to ",
      routes: {
        '/': (ctx) => TabsScreen(_favouritedMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.pageRoute: (ctx) =>
            MealDetailScreen(isMealFavourite, _togglefavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters)
        // We just made a static const variable in the CategoryMealsScreen widget
        //This is good practice because there is no chance of there being a typo
        //This avoids hardcoding the name, which is good
      },

      //onGenerateRoute loads the given page in the case where a button is trying to load a page that isn't there
      //if there is some error, like the page name not being mentioned in the routes
      onGenerateRoute: (settings) {
        print(settings.arguments);
        // if (settings.name == '/meal-details'){
        //   return ...;
        // }
        // else if (settings.name == '/something-else'){
        //   return ...;
        // }
        //Different results based on different conditions
        //This is very useful in highly dynamic applications where it isn't always pre-determined
        //where to go
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },

      //Unknown Route is reached when Flutter fails to build a screen with all other measures
      //app equivalent of 404 error
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
