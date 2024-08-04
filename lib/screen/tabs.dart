import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/provider/favorites_provider.dart';
import 'package:meals/screen/categories.dart';
import 'package:meals/screen/filters.dart';
import 'package:meals/screen/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/meal_provider.dart';

const kInitialFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree:false,
    Filter.vegetarian:false,
    Filter.vegan:false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectPageIndex = 0;
  Map<Filter,bool> _selectFiter = kInitialFilters;
  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // void _setScreen(String identifier) {
  //   Navigator.of(context).pop();
  //   if (identifier == 'filters') {
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (ctx) => const FiltersScreen(),
  //       ),
  //     );
  //   }
  // }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) =>  FiltersScreen(currentFilters: _selectFiter,),
        ),
      );
      setState(() {
      _selectFiter = result ?? kInitialFilters;
        
      });
    }
  }

  

  void _selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    final List<Meal> meals = ref.watch(mealsProvider);
    final availabeMeals = meals.where((meal) {
      if(_selectFiter[Filter.glutenFree]! && !meal.isGlutenFree ){
        return false;
      }
      else if(_selectFiter[Filter.lactoseFree]! && !meal.isLactoseFree ){
        return false;
      }
      else if(_selectFiter[Filter.vegetarian]! && !meal.isVegetarian ){
        return false;
      }
      else if(_selectFiter[Filter.vegan]! && !meal.isVegan ){
        return false;
      }
      return true;
    }).toList(); 
    
    Widget activePage = CategoriesScreen(
      availabeMeals: availabeMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectPageIndex == 1) {
      final favoriteMeals = ref.watch(favoritesMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
