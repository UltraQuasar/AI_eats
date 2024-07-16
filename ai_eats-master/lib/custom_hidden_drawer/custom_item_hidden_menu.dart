import 'package:flutter/material.dart';

class CustomItemHiddenMenu {
  /// name of the menu item
  final String name;

  /// callback to receive action click in item
  final Function? onTap;

  final Color colorLineSelected;

  /// Base style of the text-item.
  final TextStyle baseStyle;

  /// style to apply to text when item is selected
  final TextStyle selectedStyle;

  final bool selected;

  /// hinzugefügtes Icon
  final IconData? icon;

  CustomItemHiddenMenu({
    Key? key,
    required this.name,
    this.selected = false,
    this.onTap,
    this.colorLineSelected = Colors.blue,
    required this.baseStyle,
    required this.selectedStyle,
    required this.icon,
  });
}