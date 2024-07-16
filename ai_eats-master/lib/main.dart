import 'package:ai_eats/pages/ingredient_selection.dart';
import 'package:ai_eats/pages/hidden_drawer.dart';
import 'package:ai_eats/pages/preferences.dart';
import 'package:ai_eats/pages/recipe.dart';
import 'package:ai_eats/pages_hidden_drawer/favorites.dart';
import 'package:ai_eats/prompt_model/prompt_content.dart';
import 'package:ai_eats/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
final PromptGeneration promptGeneration = PromptGeneration();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => promptGeneration)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AI Eats',
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: ThemeMode.system,
        home: HiddenDrawer(),
        routes: <String, WidgetBuilder>{
          '/Ingredients': (context) => IngredientsSelection(),
          '/Preferences': (context) => const SelectPreferences(),
          '/Recipe': (context) => RecipePage(),
          '/Favorites': (context) => Favorites(),
        },
      ),
    );
  }
}
