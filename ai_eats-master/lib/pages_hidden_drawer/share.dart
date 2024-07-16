import 'package:ai_eats/home_models/bottom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../theme/theme.dart';

class SharePage extends StatelessWidget {
  const SharePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Theme.of(context).brightness == Brightness.light
                ? AssetImage(
                    'assets/icons/hidden_menu_pages/InviteAFriend_light.png')
                : AssetImage(
                    'assets/icons/hidden_menu_pages/InviteAFriend_dark.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Invite your friends',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () async {
                    final url = 'https://www.youtube.com/@glowimo_productions';
                    final result = await Share.shareWithResult(
                        'AI Eats - DOWNLOAD HERE: \n$url');

                    if (result.status == ShareResultStatus.success) {
                      print('Thank you for sharing my website!');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.share,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 15.0),
                      Text(
                        'Share',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigator(context),
    );
  }
}
