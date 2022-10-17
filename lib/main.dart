import 'package:flutter/material.dart';

import './dummy_data.dart';
import './models/meal.dart';
import './screens/filter_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/category_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;

  List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filterdata) {
    setState(() {
      _filters = filterdata;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _togglefavourite(String mealId) {
    final existingIndex = _favouriteMeals.indexWhere((meal) {
      return meal.id == mealId;
    });
    if (existingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) {
          return meal.id == mealId;
        }));
      });
    }
  }

  bool _isMealFav(String id) {
    return _favouriteMeals.any((meal) {
      return meal.id == id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DailyMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 221, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline6: TextStyle(fontSize: 20, fontFamily: 'RobotoCondensed')),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => TabsScreen(_favouriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_togglefavourite,_isMealFav),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   // if(settings.name=='.meal-detail'){
      //   //   return ...;
      //   // }
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
