import 'package:flutter/material.dart';

class FoodGroupElements extends StatefulWidget {
  final String foodCategory;
  final bool isSelected;
  final VoidCallback onTap;

  const FoodGroupElements({
    Key? key,
    required this.foodCategory,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FoodGroupElementsState();
  }
}

class _FoodGroupElementsState extends State<FoodGroupElements> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 100,
        height: 65,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                'assets/icons/food_groups/baking.jpg',
                fit: BoxFit.fill,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.0),
                color: widget.isSelected ? Colors.lightGreen : Colors.black26,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: Text(
                  widget.foodCategory,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
