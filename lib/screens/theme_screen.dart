import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meals_app/app_locale/app_localization.dart';
import 'package:meals_app/components/themes/bloc_theme/cubit.dart';
import 'package:meals_app/components/themes/bloc_theme/states.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class ThemeScreen extends StatelessWidget {
  static const routeName = "/theme";

  Widget buildListRadio({
    required ThemeMode themeVal,
    required String txt,
    IconData? icon,
    required BuildContext context,
  }) {
    return RadioListTile(
      secondary: Icon(
        icon,
        color: Theme.of(context).textTheme.bodyText1!.color,
      ),
      value: themeVal,
      groupValue: MealThemeCubit.get(context).tm,
      onChanged: (newThemeVal) =>
          MealThemeCubit.get(context).themeModeChange(newThemeVal),
      title: Text(
        txt,
        style: TextStyle(
          letterSpacing: 2.0,
        ),
      ),
    );
  }

  ListTile buildListTilePrimaryAndAccent({
    required BuildContext context,
    required String text,
  }) {
    MaterialColor primaryColor = MealThemeCubit.get(context).primaryColor;
    MaterialColor accentColor = MealThemeCubit.get(context).accentColor;

    return ListTile(
      title: Text(
        "${getLang(context, "themeText6")} $text ${getLang(context, "themeText7")} : ",
        style: Theme.of(context).textTheme.headline6,
      ),
      trailing: CircleAvatar(
        backgroundColor:
            text == getLang(context, "themeText8") ? primaryColor : accentColor,
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            elevation: 4.0,
            titlePadding: EdgeInsets.all(0.0),
            contentPadding: EdgeInsets.all(0.0),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: text == getLang(context, "themeText8")
                    ? MealThemeCubit.get(context).primaryColor
                    : MealThemeCubit.get(context).accentColor,
                onColorChanged: (newValueColor) {
                  MealThemeCubit.get(context).OnChangePrimaryBetweenAccent(
                    newValueColor,
                    text == getLang(context, "themeText8") ? 1 : 2,
                  );
                },
                colorPickerWidth: 300.0,
                pickerAreaHeightPercent: 0.7,
                enableAlpha: false,
                displayThumbColor: true,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MealThemeCubit, MealThemeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              getLang(context, "themesTitle"),
            ),
          ),
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                alignment: AlignmentDirectional.topCenter,
                child: Text(
                  getLang(context, "themeText1"),
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text(
                        getLang(context, "themeText2"),
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).textTheme.bodyText1!.color,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                    buildListRadio(
                      themeVal: ThemeMode.system,
                      txt: getLang(context, "themeText3"),
                      icon: null,
                      context: context,
                    ),
                    buildListRadio(
                      themeVal: ThemeMode.light,
                      txt: getLang(context, "themeText4"),
                      icon: Icons.wb_sunny_outlined,
                      context: context,
                    ),
                    buildListRadio(
                      themeVal: ThemeMode.dark,
                      txt: getLang(context, "themeText5"),
                      icon: Icons.nights_stay_outlined,
                      context: context,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    buildListTilePrimaryAndAccent(
                      context: context,
                      text: getLang(context, "themeText8"),
                    ),
                    buildListTilePrimaryAndAccent(
                      context: context,
                      text: getLang(context, "themeText9"),
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
