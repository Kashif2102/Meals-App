import 'package:flutter/material.dart';

import '../Models/Meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  List<Meal> fmeals;

  FavoritesScreen(this.fmeals);

  @override
  Widget build(BuildContext context) {
    if (fmeals.isEmpty) {
      return Container(
        child: Center(
            child: Text("You have no favourites yet - start adding some!")),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: fmeals[index].id,
            title: fmeals[index].title,
            imageUrl: fmeals[index].imageUrl,
            affordability: fmeals[index].affordability,
            complexity: fmeals[index].complexity,
            duration: fmeals[index].duration,
          );
        },
        itemCount: fmeals.length,
      );
    }
  }
}
