import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../main/home/home.dart';
import '../main/notifications.dart';
import '../main/search.dart';
import '../main/settings.dart';
import '../../presentation/resources/color_manager.dart';
import '../../presentation/resources/strings_manager.dart';
import '../../presentation/resources/values_manager.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    HomePage(),
    SearchPage(),
    NotificationsPage(),
    SettingsPage(),
  ];
  List<String> titles = [
    AppStrings.home,
    AppStrings.search,
    AppStrings.notifications,
    AppStrings.settings,
  ];
  var _title = AppStrings.home;
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title).tr(),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: ColorManager.lightGrey, spreadRadius: AppSize.s1)
        ]),
        child: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: ColorManager.primary,
            unselectedItemColor: ColorManager.grey,
            showSelectedLabels: false,
            currentIndex: _currentIndex,
            onTap: onTap,
            items: [
              BottomNavigationBarItem(
                  label: AppStrings.home.tr(), icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: AppStrings.search.tr(), icon: Icon(Icons.search)),
              BottomNavigationBarItem(
                  label: AppStrings.notifications.tr(),
                  icon: Icon(Icons.notifications)),
              BottomNavigationBarItem(
                  label: AppStrings.settings.tr(), icon: Icon(Icons.settings)),
            ]),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}
