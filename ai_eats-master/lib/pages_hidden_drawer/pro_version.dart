import 'package:ai_eats/home_models/bottom_navigator.dart';
import 'package:flutter/material.dart';

import '../theme/theme.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Theme.of(context).brightness == Brightness.light
                ? AssetImage(
                    'assets/icons/hidden_menu_pages/Subscription_light.png')
                : AssetImage(
                    'assets/icons/hidden_menu_pages/Subscription_dark.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Get the "Pro-Version" here!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),Text(
              '(one-time purchase)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              alignment: Alignment.bottomCenter,
              child: Center(
                /*padding: const EdgeInsets.only(
                    left: 125.0, right: 99.0, bottom: 35.0),*/
                child: ElevatedButton(
                  onPressed: () {
                    // add logout logic here
                    print('Purchase');
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
                          Icons.euro,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(width: 15.0),
                        Text(
                          'only 2,99',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
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
