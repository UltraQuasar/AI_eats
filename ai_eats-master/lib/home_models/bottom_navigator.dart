import 'package:ai_eats/prompt_model/prompt_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

BottomAppBar bottomNavigator(BuildContext context) {
  return BottomAppBar(
    color: Theme.of(context).scaffoldBackgroundColor,
    shape: CircularNotchedRectangle(),
    surfaceTintColor: Colors.transparent,
    height: 50,
    elevation: 10,
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          padding: EdgeInsets.only(top: 5),
          icon: const Icon(Icons.home),
          splashRadius: 30,
          onPressed: () {
            FocusScope.of(context).unfocus(); // Tastatur minimieren

            if (!(ModalRoute.of(context)?.settings.name == '/')) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            }
          },
        ),
        IconButton(
          padding: EdgeInsets.only(top: 7),
          icon: ColorFiltered(
            colorFilter: ColorFilter.mode(
              Theme.of(context).bottomAppBarColor,
              BlendMode.srcIn,
            ),
            child: Transform.scale(
              scale: 1.4,
              child: SvgPicture.asset(
                'assets/icons/bottom_navigator/apple_black-white.svg',
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
          splashRadius: 30,
          onPressed: () {
            FocusScope.of(context).unfocus(); // Tastatur minimieren

            if (!(ModalRoute.of(context)?.settings.name == '/')) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            }
            Navigator.pushNamed(context, '/Ingredients');
          },
        ),
        IconButton(
          padding: EdgeInsets.only(top: 5),
          icon: Icon(Icons.article_outlined),
          splashRadius: 30,
          onPressed: () {
            FocusScope.of(context).unfocus(); // Tastatur minimieren

            if (!(ModalRoute.of(context)?.settings.name == '/')) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            }
            Navigator.pushNamed(context, '/Recipe');
            Provider.of<PromptGeneration>(context, listen: false)
                .setPromptFinished(true);
          },
        ),
        IconButton(
          padding: EdgeInsets.only(top: 5),
          icon: const Icon(Icons.favorite),
          splashRadius: 30,
          onPressed: () {
            FocusScope.of(context).unfocus(); // Tastatur minimieren

            if (!(ModalRoute.of(context)?.settings.name == '/')) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            }
            Navigator.pushNamed(context, '/Favorites');
          },
        ),
        // Add more IconButton widgets as needed
      ],
    ),
  );
}
