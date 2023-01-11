import 'package:restapp/ui/favorite_page.dart';
import 'package:restapp/ui/restaurant_detail_page.dart';
import 'package:restapp/ui/restaurant_list_page.dart';
import 'package:restapp/ui/search_page.dart';
import 'package:restapp/ui/settings_pages.dart';
import 'package:flutter/material.dart';
import 'package:restapp/utility/notification_helper.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  int _bottomNavIndex = 0;
  static const String _homeText = 'Home';
  static const String _searchText = 'Search';
  static const String _favoriteText = 'Favorite';

  final List<Widget> _listWidget = const [
    RestaurantlistPage(),
    SearchPage(),
    FavoritePage(),
    SettingsPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.public),
      label: _homeText,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: _searchText,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.star),
      label: _favoriteText,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: SettingsPage.settingsTitle,
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
