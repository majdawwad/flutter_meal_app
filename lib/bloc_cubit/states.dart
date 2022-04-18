abstract class MealsStates {}

class MealsInitialState extends MealsStates {}

class MealsSetFiltersMealsState extends MealsStates {}

class MealsSetFiltersCategoryState extends MealsStates {}

class MealsIsGlutenMealState extends MealsStates {}

class MealsIsLactoseMealState extends MealsStates {}

class MealsIsVeganMealState extends MealsStates {}

class MealsIsVegetarianMealState extends MealsStates {}

class MealSaveFilterDataMealState extends MealsStates {}

class MealsTogglesFavoritesState extends MealsStates {}
