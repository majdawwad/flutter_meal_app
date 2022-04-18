import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals_app/app_locale/app_localization.dart';
import 'package:meals_app/bloc_cubit/cubit.dart';
import 'package:meals_app/bloc_cubit/states.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatelessWidget {
  static const routeName = "/filters";
  Widget buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    Function(bool)? updateValue,
    context,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
      activeColor: Theme.of(context).colorScheme.secondary,
      inactiveTrackColor: Theme.of(context).colorScheme.primary,
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, bool> currentFilters = MealsCubit.get(context).filters;
    return BlocConsumer<MealsCubit, MealsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              getLang(
                context,
                "filterTitle",
              ),
            ),
          ),
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  getLang(
                    context,
                    "filterText1",
                  ),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    buildSwitchListTile(
                      getLang(context, "filterText2"),
                      getLang(context, "filterText3"),
                      currentFilters['gluten']!,
                      (newValue) {
                        MealsCubit.get(context).isGluten(newValue);
                        MealsCubit.get(context).setFilters();
                      },
                      context,
                    ),
                    buildSwitchListTile(
                      getLang(context, "filterText4"),
                      getLang(context, "filterText5"),
                      currentFilters['lactose']!,
                      (newValue) {
                        MealsCubit.get(context).isLactose(newValue);
                        MealsCubit.get(context).setFilters();
                      },
                      context,
                    ),
                    buildSwitchListTile(
                      getLang(context, "filterText6"),
                      getLang(context, "filterText7"),
                      currentFilters['vegan']!,
                      (newValue) {
                        MealsCubit.get(context).isVegan(newValue);
                        MealsCubit.get(context).setFilters();
                      },
                      context,
                    ),
                    buildSwitchListTile(
                      getLang(context, "filterText8"),
                      getLang(context, "filterText9"),
                      currentFilters['vegetarian']!,
                      (newValue) {
                        MealsCubit.get(context).isVegetarian(newValue);
                        MealsCubit.get(context).setFilters();
                      },
                      context,
                    ),
                  ],
                ),
              ),
            ],
          ),
          drawer: MainDrawer(),
        );
      },
    );
  }
}
