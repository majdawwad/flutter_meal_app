import 'package:flutter/material.dart';
import 'package:meals_app/app_locale/app_localization.dart';
import '../widgets/main_drawer.dart';
import 'categories_screen.dart';
import 'favorites_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = 'Tabs';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>>? _pages;

  int _selectedPageIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pages = [
      {
        'page': CategoriesScreen(),
        'title': getLang(context, "CategoryNameScreen"),
      },
      {
        'page': FavoritesScreen(),
        'title': getLang(context, "FavoritesNameScreen"),
      },
    ];
  }

  void _selectPage(int value) {
    setState(() {
      _selectedPageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${_pages![_selectedPageIndex]['title']}"),
      ),
      body: _pages![_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).colorScheme.onSecondary,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: getLang(context, "CategoryNameScreen"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: getLang(context, "FavoritesNameScreen"),
          ),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
