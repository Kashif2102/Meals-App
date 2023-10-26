import 'package:flutter/material.dart';

import '../Dummy_data.dart';
import '../widgets/Category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: DUMMY_CATEGORIES
            .map(((dum_data) =>
                CategoryItem(dum_data.id, dum_data.title, dum_data.color)))
            .toList());
  }
}
