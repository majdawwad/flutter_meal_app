import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meals_app/app_locale/app_localization.dart';

import 'package:meals_app/bloc_cubit/cubit.dart';
import 'package:meals_app/components/themes/bloc_theme/cubit.dart';
import 'package:meals_app/components/themes/bloc_theme/states.dart';
import 'package:meals_app/components/themes/themes.dart';
import 'package:meals_app/screens/onboarding.dart';
import 'package:meals_app/screens/theme_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/category_meals_screen.dart';
import './screens/filters_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  late Widget isOnBoardScreen;

  bool? isOnBoarding = await sharedPreferences.getBool("onBoarding") ?? null;

  if (isOnBoarding != null) {
    isOnBoardScreen = TabsScreen();
  } else {
    isOnBoardScreen = OnBoardingScreen();
  }
  runApp(MyApp(
    isOnBoardScreen: isOnBoardScreen,
  ));
}

class MyApp extends StatelessWidget {
  final Widget isOnBoardScreen;

  const MyApp({Key? key, required this.isOnBoardScreen}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MealsCubit()..getFilterData(),
        ),
        BlocProvider(
          create: (context) => MealThemeCubit()
            ..getThemeTextMode()
            ..getChangeThemeColor(),
        ),
      ],
      child: BlocConsumer<MealThemeCubit, MealThemeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            localizationsDelegates: [
              AppLocale.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('en', ''),
              Locale('ar', ''),
            ],
            localeResolutionCallback: (currentLang, supportLang) {
              if (currentLang != null) {
                for (Locale locale in supportLang) {
                  if (locale.languageCode == currentLang.languageCode) {
                    return currentLang;
                  }
                }
              }
              return supportLang.first;
            },
            debugShowCheckedModeBanner: false,
            themeMode: MealThemeCubit.get(context).tm,
            theme: lightMode(context),
            darkTheme: darkMode(context),
            routes: {
              '/': (context) => isOnBoardScreen,
              TabsScreen.routeName: (context) => TabsScreen(),
              CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(),
              MealDetailScreen.routeName: (context) => MealDetailScreen(),
              FiltersScreen.routeName: (context) => FiltersScreen(),
              ThemeScreen.routeName: (context) => ThemeScreen(),
            },
          );
        },
      ),
    );
  }
}
