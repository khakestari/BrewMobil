import 'package:advanced_shop_app/app/app_prefs.dart';
import 'package:advanced_shop_app/app/di.dart';
import 'package:advanced_shop_app/data/data_source/local_data_source.dart';
import 'package:advanced_shop_app/presentation/resources/assets_manager.dart';
import 'package:advanced_shop_app/presentation/resources/routes_manager.dart';
import 'package:advanced_shop_app/presentation/resources/strings_manager.dart';
import 'package:advanced_shop_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AppPreferences _appPreferences = instance<AppPreferences>();
  LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(AppPadding.p8),
      children: [
        ListTile(
          title: Text(AppStrings.changeLanguage),
          leading: SvgPicture.asset(ImageAssets.changeLangIc),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
          onTap: _changeLanguage,
        ),
        ListTile(
          title: Text(AppStrings.contactUs),
          leading: SvgPicture.asset(ImageAssets.contactUsIc),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
          onTap: _contactUs,
        ),
        ListTile(
          title: Text(AppStrings.inviteYourFriends),
          leading: SvgPicture.asset(ImageAssets.inviteFriendsIc),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
          onTap: _inviteFriends,
        ),
        ListTile(
          title: Text(AppStrings.logout),
          leading: SvgPicture.asset(ImageAssets.logoutIc),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
          onTap: _logout,
        ),
      ],
    );
  }

  void _changeLanguage() {
    // will apply localization
  }

  void _contactUs() {}

  void _inviteFriends() {}

  void _logout() {
    _appPreferences.logout();
    _localDataSource.clearCache();
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.loginRoute,
      (Route<dynamic> route) => false, // This removes all routes from the stack
    );
  }
}
