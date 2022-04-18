import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meals_app/1.1%20dummy_data.dart';
import 'package:meals_app/app_locale/app_localization.dart';
import 'package:meals_app/bloc_cubit/states.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MealsCubit extends Cubit<MealsStates> {
  MealsCubit() : super(MealsInitialState());

  static MealsCubit get(context) => BlocProvider.of(context);

  String textListCategory = "dummy";

  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];
  List<String> preferdMealId = [];
  List<Category> availableCategory = DUMMY_CATEGORIES;

  void isGluten(newValue) {
    filters['gluten'] = newValue;
    emit(MealsIsGlutenMealState());
  }

  void isLactose(newValue) {
    filters['lactose'] = newValue;
    emit(MealsIsLactoseMealState());
  }

  void isVegan(newValue) {
    filters['vegan'] = newValue;
    emit(MealsIsVeganMealState());
  }

  void isVegetarian(newValue) {
    filters['vegetarian'] = newValue;
    emit(MealsIsVegetarianMealState());
  }

  void setFilters() async {
    availableMeals = DUMMY_MEALS.where((meal) {
      if (filters['gluten']! && !meal.isGlutenFree) {
        return false;
      }
      if (filters['lactose']! && !meal.isLactoseFree) {
        return false;
      }
      if (filters['vegan']! && !meal.isVegan) {
        return false;
      }
      if (filters['vegetarian']! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    emit(MealsSetFiltersMealsState());

    SharedPreferences sharePref = await SharedPreferences.getInstance();

    sharePref.setBool('gluten', filters['gluten']!);
    sharePref.setBool('lactose', filters['lactose']!);
    sharePref.setBool('vagan', filters['vegan']!);
    sharePref.setBool('vegetarian', filters['vegetarian']!);
  }

  void getFilterData() async {
    SharedPreferences sharePref = await SharedPreferences.getInstance();
    filters['gluten'] = sharePref.getBool('gluten') ?? false;
    filters['lactose'] = sharePref.getBool('lactose') ?? false;
    filters['vegan'] = sharePref.getBool('vagan') ?? false;
    filters['vegetarian'] = sharePref.getBool('vegetarian') ?? false;

    preferdMealId = sharePref.getStringList('preferdMealId') ?? [];

    for (var mealId in preferdMealId) {
      final existimgIndex =
          favoriteMeals.indexWhere((meal) => meal.id == mealId);

      if (existimgIndex <= 0) {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      }
    }

    emit(MealSaveFilterDataMealState());
  }

  void toggleFavorite(String mealId, BuildContext context) async {
    SharedPreferences sharePref = await SharedPreferences.getInstance();

    final existimgIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existimgIndex >= 0) {
      favoriteMeals.removeAt(existimgIndex);
      preferdMealId.remove(mealId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            getLang(context, "removeMealItemToast"),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    } else {
      favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      preferdMealId.add(mealId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
        content: Text(
          getLang(context, "addMealItemToast"),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
       
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      );
    }

    emit(MealsTogglesFavoritesState());

    sharePref.setStringList('preferdMealId', preferdMealId);
  }

  bool isMealFavorite(mealId) {
    return favoriteMeals.any((meal) => meal.id == mealId);
  }
}
