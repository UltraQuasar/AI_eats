import 'package:ai_eats/ingredients_selection/food.dart';
import 'package:ai_eats/settings/settings_page.dart';
import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import '../home_models/bottom_navigator.dart';
import '../home_models/create_recipes.dart';
import '../ingredients_selection/search_bar_delegate.dart';
import '../ingredients_selection/food_group_element.dart';
import '../theme/theme.dart';

class IngredientsSelection extends StatefulWidget {
  @override
  _IngredientSelection createState() => _IngredientSelection();
}

class _IngredientSelection extends State<IngredientsSelection> {
  String selectedCategory = 'All'; // Standardmäßig alle Zutaten anzeigen

  final List<Food> ingredients = FoodList.all_items;

  _IngredientSelection() {
    // Beim ersten Aufruf sollen alle Zutaten nicht ausgewählt sein
    ingredients.forEach((ingredient) {
      ingredient.isSelected = false;
    });
  }

  List<Food> getFilteredIngredients() {
    return selectedCategory == 'All'
        ? ingredients
        : ingredients
            .where((ingredient) => ingredient.category == selectedCategory)
            .toList();
  }

  @override
  Widget build(BuildContext context) {
    Brightness currentBrightness = Theme.of(context).brightness;
    String path = currentBrightness == Brightness.light
        ? 'assets/icons/logo/Title_light.png'
        : 'assets/icons/logo/Title_dark.png';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          surfaceTintColor: Colors.transparent,
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
          title: Image.asset(
            path,
            height: 25,
          ),
          centerTitle: true,
          actions: [
            /*IconButton(
              icon: Icon(
                Icons.add,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    String newItem = '';

                    return SimpleDialog(
                      title: const Text(
                        'Add your custom ingredient here:',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                      contentPadding: const EdgeInsets.only(
                          left: 20.0, top: 20.0, right: 20.0, bottom: 5.0),
                      children: [
                        TextField(
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                          cursorColor: Theme.of(context).primaryColor,
                          onChanged: (value) {
                            newItem = value;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.deny('\n')
                          ],
                          maxLength: 20,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            print(
                                'Request to ChatGPT: Please answer with true if $newItem is an valid eatable ingredient, or simply false, if it is not. Your answer must be just one word.');
                            /*if (answer.isEqual("true" | "True" | "TRUE")) {
                              FoodList.insertFoodItem(newItem);
                            }*/
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'SEND REQUEST',
                            style: TextStyle(fontSize: 18, color: green),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),*/
            IconButton(
              icon: Icon(Icons.language),
              color: Theme.of(context).primaryColor,
              onPressed: () => Settings.changeLanguage(),
            ),
            IconButton(
              icon: Icon(Icons.search),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MySearchDelegate(),
                );
              },
            )
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          child: Column(
            children: [
              _buildCategorySelector(),
              Expanded(
                child: _buildIngredientList(),
              ),
            ],
          ),
        ),
        bottomNavigationBar: bottomNavigator(context),
        floatingActionButton: createRecipesButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget _buildCategorySelector() {
    List<String> categories = ['All'] +
        ingredients
            .where((ingredient) => ingredient.category != 'All')
            .map((ingredient) => ingredient.category)
            .toSet()
            .toList();

    return Container(
      padding: EdgeInsets.all(16.0),
      height: 85,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          String category = categories[index];

          return Row(
            children: [
              FoodGroupElements(
                foodCategory: category,
                isSelected: selectedCategory == category,
                onTap: () {
                  setState(() {
                    selectedCategory = category;
                  });
                },
              ),
              SizedBox(width: 8),
            ],
          );
        },
      ),
    );
  }

  Widget _buildIngredientList() {
    List<Food> items = getFilteredIngredients();

    // Sort the ingredients for AzListView
    SuspensionUtil.sortListBySuspensionTag(items);
    SuspensionUtil.setShowSuspensionStatus(items);

    return AzListView(
      data: items,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Padding(
          padding: EdgeInsets.only(left: 15.0, right: 45.0),
          child: _buildListItem(item),
        );
      },
      indexHintBuilder: (context, hint) => Container(
        alignment: Alignment.center,
        width: 60,
        height: 75,
        decoration: BoxDecoration(
          color: green,
          shape: BoxShape.circle,
        ),
        child: Text(
          hint,
          style: TextStyle(color: white, fontSize: 35),
        ),
      ),
      indexBarMargin: EdgeInsets.all(10),
      indexBarItemHeight: 20,
      indexBarData: SuspensionUtil.getTagIndexList(items),
      indexBarOptions: IndexBarOptions(
        indexHintChildAlignment: Alignment.center,
        needRebuild: true,
        selectTextStyle: TextStyle(color: white),
        selectItemDecoration: BoxDecoration(
          color: green,
          shape: BoxShape.circle,
        ),
        indexHintAlignment: Alignment.centerRight,
        indexHintOffset: Offset(-20, 0),
      ),
    );
  }

  Widget _buildListItem(Food item) {
    final tag = item.getSuspensionTag();
    final offstage = !item.isShowSuspension;

    return Column(children: [
      Offstage(offstage: offstage, child: buildHeader(tag)),
      Container(
        margin: EdgeInsets.only(right: 16),
        child: ListTile(
          title: Text(item.name,
              style: TextStyle(color: Theme.of(context).primaryColor)),
          leading: Image.asset(
            item.imagePath,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
          onTap: () {
            setState(() {
              item.isSelected = !item.isSelected;
            });
          },
          tileColor: item.isSelected ? green : null,
        ),
      ),
    ]);
  }

  Widget buildHeader(String tag) => Container(
        height: 30,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: Divider(color: lightGrey),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    tag,
                    style: TextStyle(fontSize: 12, color: lightGrey),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Divider(),
                ),
              ],
            ),
          ],
        ),
      );
}
