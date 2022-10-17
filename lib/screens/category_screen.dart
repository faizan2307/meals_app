import 'package:flutter/material.dart';
import '../widgets/category_item.dart';

import '../dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return  GridView(
        padding: const EdgeInsets.all(25.0),
        children: DUMMY_CATEGORIES
            .map(
              (catData) =>
                  CategoryItem(catData.title, catData.color, catData.id),
            )
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20),
      
    );
  }
}
