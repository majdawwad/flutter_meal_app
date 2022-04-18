import 'package:flutter/material.dart';
import 'package:meals_app/components/themes/bloc_theme/cubit.dart';

ThemeData lightMode(context) => ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MealThemeCubit.get(context).primaryColor,
      ).copyWith(
        secondary: MealThemeCubit.get(context).accentColor,
      ),
      canvasColor: Color.fromRGBO(255, 254, 229, 1),
      fontFamily: 'Raleway',
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.black87,
      ),
      cardColor: Colors.white,
      shadowColor: Colors.black54,
      textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(20, 50, 50, 1),
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(20, 50, 50, 1),
            ),
            headline6: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            ),
          ),
    );

ThemeData darkMode(context) => ThemeData(
      colorScheme: ColorScheme.fromSwatch(
              primarySwatch: MealThemeCubit.get(context).primaryColor)
          .copyWith(
        secondary: MealThemeCubit.get(context).accentColor,
      ),
      canvasColor: Color.fromRGBO(14, 22, 33, 1),
      fontFamily: 'Raleway',
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.white70,
      ),
      cardColor: Color.fromRGBO(35, 34, 39, 1),
      shadowColor: Colors.white60,
      textTheme: ThemeData.dark().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Colors.white70,
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(35, 34, 39, 1),
            ),
            headline6: TextStyle(
              color: Colors.white70,
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            ),
          ),
    );
