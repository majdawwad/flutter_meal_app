import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meals_app/bloc_cubit/cubit.dart';
import 'package:meals_app/bloc_cubit/states.dart';

import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MealsCubit, MealsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: GridView(
            padding: EdgeInsets.all(25),
            children: MealsCubit.get(context)
                .availableCategory
                .map(
                  (catData) => CategoryItem(catData.id, catData.color),
                )
                .toList(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
          ),
        );
      },
    );
  }
}
