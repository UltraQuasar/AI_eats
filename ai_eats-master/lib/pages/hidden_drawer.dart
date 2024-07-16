import 'package:ai_eats/pages_hidden_drawer/agb.dart';
import 'package:ai_eats/pages_hidden_drawer/favorites.dart';
import 'package:ai_eats/pages_hidden_drawer/home.dart';
import 'package:flutter/material.dart';

import '../custom_hidden_drawer/custom_hidden_drawer_menu.dart';
import '../custom_hidden_drawer/custom_item_hidden_menu.dart';
import '../custom_hidden_drawer/custom_screen_hidden_drawer.dart';
import '../pages_hidden_drawer/feedback_contact_us.dart';
import '../pages_hidden_drawer/share.dart';
import '../pages_hidden_drawer/pro_version.dart';
import '../settings/settings_page.dart';
import '../theme/theme.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key});

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle =
        TextStyle(color: Theme.of(context).disabledColor, fontSize: 16);
    final TextStyle selectedStyle =
        TextStyle(color: green, fontWeight: FontWeight.bold, fontSize: 20);
    final Color colorLineSelected = green;

    List<CustomScreenHiddenDrawer> pages = [
      CustomScreenHiddenDrawer(
          CustomItemHiddenMenu(
            name: 'Home',
            baseStyle: baseStyle,
            selectedStyle: selectedStyle,
            colorLineSelected: colorLineSelected,
            icon: Icons.home,
          ),
          HomePage()),
      CustomScreenHiddenDrawer(
          CustomItemHiddenMenu(
            name: 'My Recipes',
            baseStyle: baseStyle,
            selectedStyle: selectedStyle,
            colorLineSelected: colorLineSelected,
            icon: Icons.favorite,
          ),
          Favorites()),
      /* CustomScreenHiddenDrawer(
          CustomItemHiddenMenu(
            name: 'My Profile',
            baseStyle: baseStyle,
            selectedStyle: selectedStyle,
            colorLineSelected: colorLineSelected,
            icon: Icons.account_box_rounded,
          ),
          HomePage()), */
      CustomScreenHiddenDrawer(
          CustomItemHiddenMenu(
            name: 'Pro Version',
            baseStyle: baseStyle,
            selectedStyle: selectedStyle,
            colorLineSelected: colorLineSelected,
            icon: Icons.attach_money,
          ),
          SubscriptionPage()),
      CustomScreenHiddenDrawer(
          CustomItemHiddenMenu(
            name: 'Share',
            baseStyle: baseStyle,
            selectedStyle: selectedStyle,
            colorLineSelected: colorLineSelected,
            icon: Icons.launch,
          ),
          SharePage()),
      /*CustomScreenHiddenDrawer(
          CustomItemHiddenMenu(
            name: 'Help & FAQ',
            baseStyle: baseStyle,
            selectedStyle: selectedStyle,
            colorLineSelected: colorLineSelected,
            icon: Icons.help,
          ),
          HomePage()),*/
      CustomScreenHiddenDrawer(
          CustomItemHiddenMenu(
            name: 'Contact Us',
            baseStyle: baseStyle,
            selectedStyle: selectedStyle,
            colorLineSelected: colorLineSelected,
            icon: Icons.alternate_email,
          ),
          Contact()),
      CustomScreenHiddenDrawer(
          CustomItemHiddenMenu(
            name: 'AGBs',
            baseStyle: baseStyle,
            selectedStyle: selectedStyle,
            colorLineSelected: colorLineSelected,
            icon: Icons.article,
          ),
          AGBs()),
    ];

    Brightness currentBrightness = Theme.of(context).brightness;
    String path = currentBrightness == Brightness.light
        ? 'assets/icons/logo/Title_light.png'
        : 'assets/icons/logo/Title_dark.png';

    return HiddenDrawerMenu(
      backgroundColorMenu: RadialGradient(
        colors: currentBrightness == Brightness.dark
            ? [lightBrown, brown, darkBrown, black]
            : [white, lightBrown, brown],
        stops: currentBrightness == Brightness.dark
            ? [0.175, 0.275, 0.325, 0.4]
            : [0.1, 0.35, 0.4],
        center: Alignment(10.0, 0.0),
        radius: 10,
        focal: Alignment(4, 0.0),
        tileMode: TileMode.clamp,
      ),
      screens: pages,
      initPositionSelected: 0,
      slidePercent: 65.0,
      backgroundColorAppBar: Theme.of(context).scaffoldBackgroundColor,
      leadingAppBar: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Icon(Icons.person),
      ),
      tittleAppBar: Image.asset(
        path,
        height: 25,
        alignment: Alignment.center,
      ),
      isTitleCentered: true,
      actionsAppBar: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ),
      ],
    );
  }
}
