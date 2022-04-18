import 'package:flutter/material.dart';
import 'package:meals_app/app_locale/app_localization.dart';
import 'package:meals_app/screens/theme_screen.dart';
import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(
    String title,
    IconData icon,
    Function()? tapHandler,
    context,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Theme.of(context).textTheme.bodyText1!.color,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1!.color,
          fontSize: 24,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: getLang(context, "lang") == "arabic"
                ? Alignment.centerRight
                : Alignment.centerLeft,
            color: Theme.of(context).colorScheme.secondary,
            child: Text(
              "${getLang(context, "drawerName")}",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(height: 20),
          buildListTile(
            "${getLang(context, "drawerItem1")}",
            Icons.restaurant,
            () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            context,
          ),
          buildListTile(
            "${getLang(context, "drawerItem2")}",
            Icons.settings,
            () {
              Navigator.of(context)
                  .pushReplacementNamed(FiltersScreen.routeName);
            },
            context,
          ),
          buildListTile(
            "${getLang(context, "drawerItem3")}",
            Icons.color_lens_rounded,
            () {
              Navigator.of(context).pushReplacementNamed(ThemeScreen.routeName);
            },
            context,
          ),
        ],
      ),
    );
  }
}
