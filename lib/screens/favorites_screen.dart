import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals_app/bloc_cubit/cubit.dart';
import 'package:meals_app/bloc_cubit/states.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Meal> favoriteMeals = MealsCubit.get(context).favoriteMeals;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var deviceWidth = MediaQuery.of(context).size.width;

    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text("You have no favorites yet - start adding some!"),
      );
    } else {
      return BlocConsumer<MealsCubit, MealsStates>(
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
                id: favoriteMeals[index].id,
                imageUrl: favoriteMeals[index].imageUrl,
                duration: favoriteMeals[index].duration,
              );
            },
            itemCount: favoriteMeals.length,
          );
        },
      );
    }
  }
}
