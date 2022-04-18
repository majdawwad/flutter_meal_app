import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals_app/app_locale/app_localization.dart';
import 'package:meals_app/bloc_cubit/cubit.dart';
import 'package:meals_app/bloc_cubit/states.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = 'category_meals';

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  List<Meal>? displayedMeals;

  @override
  void didChangeDependencies() {
    final List<Meal> availableMeals = MealsCubit.get(context).availableMeals;
    final routeArg =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryId = routeArg['id'];
    categoryTitle = getLang(context, "category-$categoryId");
    displayedMeals = availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  void removeMeal(String mealId) {
    setState(() {
      displayedMeals!.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle!)),
      body: BlocConsumer<MealsCubit, MealsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: deviceWidth <= 500 ? 500 : 510,
              childAspectRatio: isLandscape
                  ? deviceWidth / (deviceWidth * 0.8)
                  : deviceWidth / (deviceWidth * 0.75),
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
            ),
            itemBuilder: (ctx, index) {
              return MealItem(
                id: displayedMeals![index].id,
                imageUrl: displayedMeals![index].imageUrl,
                duration: displayedMeals![index].duration,
              );
            },
            itemCount: displayedMeals!.length,
          );
        },
      ),
    );
  }
}
