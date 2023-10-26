import 'package:flutter/material.dart';
import 'package:meals_app/screens/Category_Meals_Screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem(this.id, this.title, this.color);

  // void page_Switch(BuildContext ctx) {
  //   Navigator.of(ctx).push(MaterialPageRoute(
  //     builder: (_) {
  //       return CategoryMealsScreen(id,title);
  //     },
  //   ));
  // }

  void page_Switch(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
        /* '/category-meals' */ CategoryMealsScreen.routeName,
        arguments: {'id': id, 'title': title});
  } //same thing here, we cannot make a typo referencing a member of a class

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() => page_Switch(context)),
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [color.withOpacity(0.7), color],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
