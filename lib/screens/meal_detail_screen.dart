import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals_app/1.1 dummy_data.dart';
import 'package:meals_app/app_locale/app_localization.dart';
import 'package:meals_app/bloc_cubit/cubit.dart';
import 'package:meals_app/bloc_cubit/states.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = 'meal_detail';

  Widget buildSectionTitle(
    BuildContext context,
    String text,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1!.color,
        ),
      ),
    );
  }

  Widget buildContainer(
    Widget child,
    context,
  ) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: Theme.of(context).cardColor,
            spreadRadius: 5.0,
          ),
        ],
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      margin: EdgeInsets.all(
        10,
      ),
      padding: EdgeInsets.all(
        10,
      ),
      height: isLandscape ? deviceHeight * 0.5 : deviceHeight * 0.25,
      width: isLandscape ? (deviceWidth * 0.5 - 25) : deviceWidth,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    // For Ingredients
    var selectedIngredients = getLang(context, "ingredients-$mealId");
    selectedIngredients = selectedIngredients.replaceAll(RegExp("\\[|\\]"), '');
    var Ingredients = selectedIngredients.split(',');

    // For Steps
    var selectedSteps = getLang(context, "steps-$mealId");
    selectedSteps = selectedSteps.replaceAll(RegExp("\\[|\\]"), '');
    var Steps = selectedIngredients.split(',');

    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    var listSteps = ListView.builder(
      itemBuilder: (ctx, index) => Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text(
                "${index + 1}",
              ),
            ),
            title: Text(
              Steps[index],
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText2!.color,
              ),
            ),
          ),
          Divider(),
        ],
      ),
      itemCount: Steps.length,
    );

    var listStepsDetails = ListView.builder(
      itemBuilder: (ctx, index) => Card(
        color: Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Text(
            Ingredients[index],
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText2!.color,
            ),
          ),
        ),
      ),
      itemCount: Ingredients.length,
    );

    return BlocConsumer<MealsCubit, MealsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text("${getLang(context, "meal-$mealId")}"),
                  background: Hero(
                    tag: mealId,
                    child: InteractiveViewer(
                      child: CachedNetworkImage(
                        imageUrl: selectedMeal.imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    if (isLandscape)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              buildSectionTitle(
                                context,
                                getLang(context, "ingredients"),
                              ),
                              buildContainer(
                                listStepsDetails,
                                context,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              buildSectionTitle(
                                context,
                                getLang(context, "steps"),
                              ),
                              buildContainer(
                                listSteps,
                                context,
                              ),
                            ],
                          ),
                        ],
                      ),
                    if (!isLandscape)
                      buildSectionTitle(
                        context,
                        getLang(context, "ingredients"),
                      ),
                    if (!isLandscape)
                      buildContainer(
                        listStepsDetails,
                        context,
                      ),
                    if (!isLandscape)
                      buildSectionTitle(
                        context,
                        getLang(context, "steps"),
                      ),
                    if (!isLandscape)
                      buildContainer(
                        listSteps,
                        context,
                      ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              MealsCubit.get(context).toggleFavorite(mealId, context);
            },
            child: Icon(
              MealsCubit.get(context).isMealFavorite(mealId)
                  ? Icons.star
                  : Icons.star_border,
            ),
          ),
        );
      },
    );
  }
}
