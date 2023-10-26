import 'package:flutter/material.dart';
import 'package:meals_app/Models/Meal.dart';

import '../widgets/meal_item.dart';
import '../Dummy_data.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  // final String category_id;

  late String? categoryTitle;
  late List<Meal> displayedMeals;
  var _loadedInitdata = false;

  @override

  // void initState() {
  //   final routeArgs =
  //       ModalRoute.of(context)!.settings.arguments as Map<String, String>;
  //   categoryTitle = routeArgs['title'];
  //   final category_id = routeArgs['id'];

  //   displayedMeals = DUMMY_MEALS.where((meal) {
  //     return meal.categories.contains(category_id);
  //   }).toList();
  //   super.initState();
  // }

  //initState here will throw an error because everything inside it is
  //initialised even before the Build Method is executed,
  //So there is no (context) for the ModalRoute to use
  //this will remain true always, we cannot use context stuff
  //inside initState, so we use didChangeDependencies

  //both of them are called before build is called.
  //The only difference is that one is called before the state loads
  //its dependencies and the other is called a few moments after the
  //state loads its dependencies. So build is available at that moment.

  @override
  void didChangeDependencies() {
    if (!_loadedInitdata) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final category_id = routeArgs['id'];

      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(category_id);
      }).toList();
      _loadedInitdata = true;
    }

    super.didChangeDependencies();
  }

//We needed to initialise the data earlier than before so we could use the meal.id
//for our function
  void _removeMeal(String mealid) {
    setState(() {
      displayedMeals.removeWhere((m) => m.id == mealid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(categoryTitle as String)),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayedMeals[index].id,
              title: displayedMeals[index].title,
              imageUrl: displayedMeals[index].imageUrl,
              affordability: displayedMeals[index].affordability,
              complexity: displayedMeals[index].complexity,
              duration: displayedMeals[index].duration,
            );
          },
          itemCount: displayedMeals.length,
        ));
  }
}
