import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals_app/components/themes/bloc_theme/states.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MealThemeCubit extends Cubit<MealThemeStates> {
  MealThemeCubit() : super(MealThemeInitialState());

  static MealThemeCubit get(context) => BlocProvider.of(context);

  var primaryColor = Colors.pink;
  var accentColor = Colors.amber;
  var tm = ThemeMode.system;
  String textMode = "s";

  MaterialColor setMaterialColor(colorValue) {
    return MaterialColor(
      colorValue,
      <int, Color>{
        50: Color(0xFFFFEBEE),
        100: Color(0xFFFFCDD2),
        200: Color(0xFFEF9A9A),
        300: Color(0xFFE57373),
        400: Color(0xFFEF5350),
        500: Color(colorValue),
        600: Color(0xFFE53935),
        700: Color(0xFFD32F2F),
        800: Color(0xFFC62828),
        900: Color(0xFFB71C1C),
      },
    );
  }

  Future<void> OnChangePrimaryBetweenAccent(newColor, number) async {
    number == 1
        ? primaryColor = setMaterialColor(newColor.hashCode)
        : accentColor = setMaterialColor(newColor.hashCode);

    emit(MealThemeOnChangePrimaryBetweenAccentColorState());

    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setInt("primaryColor", primaryColor.value);
    pref.setInt("accentColor", accentColor.value);
  }

  void getChangeThemeColor() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    primaryColor = setMaterialColor(pref.getInt("primaryColor") ?? 0xFFE91E63);
    accentColor = setMaterialColor(pref.getInt("accentColor") ?? 0xFFFFC107);

    emit(MealThemeGetChangeThemeColorState());
  }

  Future<void> themeModeChange(newThemeVal) async {
    tm = newThemeVal;
    getTextMode(tm);
    emit(MealThemeNewThemeModeValue());

    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString("textMode", textMode);
    print(pref.getString("textMode"));
  }

  void getThemeTextMode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    textMode = pref.getString("textMode") ?? "s";

    if (textMode == "d")
      tm = ThemeMode.dark;
    else if (textMode == "l")
      tm = ThemeMode.light;
    else if (textMode == "s") tm = ThemeMode.system;

    emit(MealThemeGetThemeTextModeState());
  }

  void getTextMode(ThemeMode tm) {
    if (tm == ThemeMode.dark)
      textMode = "d";
    else if (tm == ThemeMode.light)
      textMode = "l";
    else if (tm == ThemeMode.system) textMode = "s";
  }
}
