import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:project07/const/common/colors.dart';
import 'package:project07/presentation/screens/fav_screen.dart';
import 'package:project07/presentation/screens/homeScreen2.dart';
import 'package:project07/presentation/screens/home_screen.dart';
import 'package:project07/presentation/screens/profile_screen.dart';
import 'package:project07/size/size.dart';
import 'package:project07/themes/theme_model.dart';
import 'package:provider/provider.dart';

class CustomNavigationBarScreen extends StatefulWidget {
  @override
  State<CustomNavigationBarScreen> createState() =>
      _CustomNavigationBarScreenState();
}

class _CustomNavigationBarScreenState extends State<CustomNavigationBarScreen> {
  bool _isDark = false;
  int index = 1;
  final screens = [
    const FavScreen(),
    //const Home(),
    const HomeScreen(),
    const ProfileScreen(),
  ];

  final icons = [
    Icon(
      Icons.favorite,
      color: mainColor,
    ),
    Icon(
      Icons.home,
      color: mainColor,
    ),
    Icon(
      Icons.account_circle,
      color: mainColor,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, ThemeModel themeNotifier, child) {
        return Scaffold(
            extendBody: true,
            body: screens[index],
            bottomNavigationBar: CurvedNavigationBar(
              height: sizeFromHeight(context,12),
              buttonBackgroundColor:
                  themeNotifier.isDark ? Colors.white : Colors.grey.shade900,
              backgroundColor:
                  themeNotifier.isDark ? Color(0xFF0E0E0F) : Colors.white,
              color: themeNotifier.isDark ? whiteColor : blackColor,
              index: index,
              onTap: (pageIndex) => setState(() => this.index = pageIndex),
              items: [
                Icon(
                  Icons.favorite,
                  color: themeNotifier.isDark? Color(0xFF0E0E0F) : whiteColor,
                ),
                Icon(
                  Icons.home,
                  color: themeNotifier.isDark? Color(0xFF0E0E0F) : whiteColor,
                ),
                Icon(
                  Icons.account_circle,
                  color: themeNotifier.isDark? Color(0xFF0E0E0F) : whiteColor,
                ),
              ],

            ));
      },
    );

  }
}
