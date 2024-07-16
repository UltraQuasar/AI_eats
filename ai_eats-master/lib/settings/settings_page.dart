import 'package:ai_eats/pages_hidden_drawer/agb.dart';
import 'package:ai_eats/pages_hidden_drawer/feedback_contact_us.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '../theme/theme.dart';
import 'not_implemented_dialog.dart';

class Settings {
  static bool english = true;
  static bool german = !english;

  static bool notificationsEnabled = true;
  static String theme = 'System';

  static bool loggedIn = false;
  static bool proVersion = false;

  static void changeLanguage() {
    english = !english;
    german = !german;
    print('Language changed');
  }

  static void changeNotifications() {
    notificationsEnabled = !notificationsEnabled;
    print('Notifications changed');
  }

  static void changeTheme(bool bright) {
    theme = bright ? "LightMode" : "DarkMode";
    print('Theme changed');
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;
  double fontSize = 16.0;
  String theme = 'Light';

  @override
  Widget build(BuildContext context) {
    bool designIsSwitched = true; // Initial value for the switch
    bool notificationsAreSwitched = true; // Initial value for the switch

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile & Settings'),
        titleTextStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 22,
            fontWeight: FontWeight.bold),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          splashRadius: 30,
          alignment: Alignment.center,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      extendBodyBehindAppBar: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('PROFILE'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.language),
                title: Text('Account'),
                value: Text('Profile Picture - Name - Password - Logout'),
                trailing: Icon(Icons.arrow_forward_ios, color: grey, size: 20),
                onPressed: (context) => showDialog(
                  context: context,
                  builder: (context) => NotImplementedDialog(context),
                ),
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.dashboard_customize),
                title: Text('Food Preferences'),
                value: Text('Intolerances - Restrictions - Cuisines'),
                trailing: Icon(Icons.arrow_forward_ios, color: grey, size: 20),
                onPressed: (context) => showDialog(
                  context: context,
                  builder: (context) => NotImplementedDialog(context),
                ),
              ),
            ],
          ),
          SettingsSection(
            title: Text('SYSTEM'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.language),
                title: Text('Language'),
                value: Text('English - Deutsch'),
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_left),
                      onPressed: () {
                        setState(() {
                          Settings.changeLanguage();
                        });
                      },
                    ),
                    Center(
                      child: Settings.english
                          ? Text('ENGLISH', style: TextStyle(fontSize: 18))
                          : Text('DEUTSCH', style: TextStyle(fontSize: 17.5)),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_right),
                      onPressed: () {
                        setState(() {
                          Settings.changeLanguage();
                        });
                      },
                    ),
                  ],
                ),
              ),
              SettingsTile.switchTile(
                  activeSwitchColor: green,
                // assuming `green` is defined
                onToggle: (value) {
                  setState(() {
                    Settings.changeTheme(value);
                    value = !value;
                  });
                },
                initialValue: true,
                leading: Icon(Icons.brightness_4),
                title: Text('Design'),
                description: Text('Light Mode - Dark Mode'),
              ),
              SettingsTile.switchTile(
                activeSwitchColor: green,
                onToggle: (value) {
                  setState(() {
                    designIsSwitched = value;
                  });
                },
                initialValue: designIsSwitched,
                leading: Icon(Icons.notifications),
                title: Text('Notifications'),
              ),
            ],
          ),
          SettingsSection(
            title: Text('CONTACT'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.live_help),
                title: Text('Help & FAQ'),
                trailing: Icon(Icons.arrow_forward_ios, color: grey, size: 20),
                onPressed: (context) => showDialog(
                  context: context,
                  builder: (context) => NotImplementedDialog(context),
                ),
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.alternate_email_outlined),
                title: Text('Support & Feedback'),
                trailing: Icon(Icons.arrow_forward_ios, color: grey, size: 20),
                onPressed: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Contact()),
                  );
                },
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.article),
                title: Text('About Us'),
                value: Text('Privacy Statement - Terms & Conditions - Imprint'),
                trailing: Icon(Icons.arrow_forward_ios, color: grey, size: 20),
                onPressed: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AGBs()),
                  );
                },
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.info_outline),
                title: Text('App Info'),
                value: Text('Version - Download Images - Updates'),
                trailing: Icon(Icons.arrow_forward_ios, color: grey, size: 20),
                onPressed: (context) => showDialog(
                  context: context,
                  builder: (context) => NotImplementedDialog(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
