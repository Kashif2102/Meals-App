import 'package:flutter/material.dart';

import '../Dummy_data.dart';

class MealDetailScreen extends StatefulWidget {
  static const pageRoute = '/Meal-Detail-Screen';

  final Function togglefav;
  final Function isfav;

  MealDetailScreen(this.isfav, this.togglefav);

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(10),
        height: 150,
        width: 300,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
        appBar: AppBar(
          title: Text("${selectedMeal.title}"),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text(selectedMeal.ingredients[index])),
                  );
                },
              ),
            ),
            buildSectionTitle(context, "Steps"),
            buildContainer(ListView.builder(
              itemCount: selectedMeal.steps.length,
              itemBuilder: (ctx, index) {
                return Column(children: [
                  ListTile(
                    leading: CircleAvatar(child: Text('# ${(index + 1)}')),
                    title: Text(selectedMeal.steps[index]),
                  ),
                  Divider(),
                ]);
              },
            )),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(widget.isfav(mealId) ? Icons.star : Icons.star_border),
          onPressed: () => setState(() {
            widget.togglefav(mealId);
          }),
        ));
  }
}

//Converted widget to stateful and wrapped "widget.togglefav(mealId)" in 
// setState in order to achieve favourite button changing on press in realtime

//A dirty fix for things not updating on the screen is to 
//convert the widget to a stateful widget and then calling an empty 
//SetState to force an update
//But this can be dealt with better if we use state management
