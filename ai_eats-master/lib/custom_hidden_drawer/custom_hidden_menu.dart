import 'dart:io';

import 'package:ai_eats/custom_hidden_drawer/custom_item_hidden_menu.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/animated_drawer_content.dart';

import '../theme/theme.dart';
import 'custom_hidden_menu_item.dart';

class CustomHiddenMenu extends StatefulWidget {
  /// Decocator that allows us to add backgroud in the menu(img)
  final DecorationImage? background;

  /// that allows us to add shadow above menu items
  final bool enableShadowItemsMenu;

  /// that allows us to add backgroud in the menu(color)
  final Gradient backgroundColorMenu;

  /// Items of the menu
  final List<CustomItemHiddenMenu> items;

  /// Callback to receive item selected for user
  final Function(int)? selectedListen;

  /// position to set initial item selected in menu
  final int initPositionSelected;

  final TypeOpen typeOpen;

  CustomHiddenMenu({
    Key? key,
    required this.background,
    required this.items,
    this.selectedListen,
    required this.initPositionSelected,
    required this.backgroundColorMenu,
    this.enableShadowItemsMenu = false,
    this.typeOpen = TypeOpen.FROM_LEFT,
  }) : super(key: key);

  @override
  _HiddenMenuState createState() => _HiddenMenuState();
}

class _HiddenMenuState extends State<CustomHiddenMenu> {
  late int _indexSelected;
  late SimpleHiddenDrawerController controller;

  @override
  void initState() {
    _indexSelected = widget.initPositionSelected;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    controller = SimpleHiddenDrawerController.of(context);
    controller.addListener(_listenerController);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.removeListener(_listenerController);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: widget.background,
          gradient: widget.backgroundColorMenu,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Round Profile Picture
              Padding(
                padding: const EdgeInsets.only(left: 40.0, top: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/icons/logo/Logo.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'User Name',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: white),
                    ),
                    Text(
                      'email@example.com',
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Theme.of(context).disabledColor),
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),

              // Menu
              Container(
                padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
                decoration: BoxDecoration(
                  boxShadow: widget.enableShadowItemsMenu
                      ? [
                          BoxShadow(
                            color: const Color(0x44000000),
                            offset: const Offset(0.0, 5.0),
                            blurRadius: 50.0,
                            spreadRadius: 30.0,
                          ),
                        ]
                      : [],
                ),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.all(0.0),
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    return CustomHiddenMenuItem(
                      name: widget.items[index].name,
                      iconData: widget.items[index].icon,
                      selected: index == _indexSelected,
                      colorLineSelected: widget.items[index].colorLineSelected,
                      baseStyle: widget.items[index].baseStyle,
                      selectedStyle: widget.items[index].selectedStyle,
                      typeOpen: widget.typeOpen,
                      onTap: () {
                        if (widget.items[index].onTap != null) {
                          widget.items[index].onTap!();
                        }
                        controller.setSelectedMenuPosition(index);
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 75.0),

              // Close Button
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(left: 25),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {

                        return SimpleDialog(
                          title: const Text(
                            'Are you sure you want to close the app?',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 20.0, top: 20.0, right: 20.0, bottom: 5.0),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text(
                                    'No, stay here.',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: green,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                TextButton(
                                  onPressed: () => exit(0),
                                  child: Text(
                                    'Yes, close!',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).disabledColor,
                    foregroundColor: green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.logout,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 15.0),
                      // Add some space between the icon and text
                      Text(
                        'Close',
                        style: TextStyle(
                          fontSize: 15.0, // Set the text font size
                          color: Theme.of(context)
                              .primaryColor, // Set the text color
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _listenerController() {
    setState(() {
      _indexSelected = controller.position;
    });
  }
}
