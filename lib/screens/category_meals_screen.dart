import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item.dart';

import '../dummy_data.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;
  CategoryMealsScreen(this.availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  // final String categoryId;
  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadinitdata = false;
  // @override
  // void initState() {

  // }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (!_loadinitdata) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayedMeals = DUMMY_MEALS.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadinitdata = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: ((context, index) {
          return MealItem(
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
            id: displayedMeals[index].id,
            // removeItem: _removeMeal,
          );
        }),
        itemCount: displayedMeals.length,
      ),
    );
  }
}
