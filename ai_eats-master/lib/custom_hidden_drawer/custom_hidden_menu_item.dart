import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/animated_drawer_content.dart';
import 'package:ai_eats/theme/theme.dart';

class CustomHiddenMenuItem extends StatelessWidget {
  final String name;
  final GestureTapCallback? onTap;
  final Color colorLineSelected;
  final TextStyle? baseStyle;
  final TextStyle? selectedStyle;
  final bool selected;
  final TypeOpen typeOpen;
  final IconData? iconData; // Icon hinzugefügt

  const CustomHiddenMenuItem({
    Key? key,
    required this.name,
    this.onTap,
    required this.colorLineSelected,
    this.baseStyle,
    this.selectedStyle,
    required this.selected,
    required this.typeOpen,
    this.iconData, // Icon hinzugefügt
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            if (typeOpen == TypeOpen.FROM_LEFT)
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(4.0),
                  bottomRight: Radius.circular(4.0),
                ),
                child: Container(
                  height: 40.0,
                  color: selected ? colorLineSelected : Colors.transparent,
                  width: 5.0,
                ),
              ),
            // Icon hinzugefügt
            if (iconData != null)
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 5.0),
                child: Icon(iconData, color: selected ? green : Theme.of(context).disabledColor),
              ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  left: typeOpen == TypeOpen.FROM_LEFT ? 10 : 0.0, // Änderung der linken Marge
                  right: typeOpen == TypeOpen.FROM_RIGHT ? 10 : 0.0, // Änderung der rechten Marge
                ),
                child: Text(
                  name,
                  style: _getStyle().merge(_getStyleSelected()),
                  textAlign: typeOpen == TypeOpen.FROM_RIGHT
                      ? TextAlign.right
                      : TextAlign.left,
                ),
              ),
            ),
            if (typeOpen == TypeOpen.FROM_RIGHT)
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  bottomLeft: Radius.circular(4.0),
                ),
                child: Container(
                  height: 40.0,
                  color: selected ? colorLineSelected : Colors.transparent,
                  width: 5.0,
                ),
              ),
          ],
        ),
      ),
    );
  }

  TextStyle? _getStyleSelected() {
    return this.selected
        ? this.selectedStyle ?? TextStyle(color: Colors.white)
        : null;
  }

  TextStyle _getStyle() {
    return this.baseStyle ?? TextStyle(color: Colors.grey, fontSize: 25.0);
  }
}
