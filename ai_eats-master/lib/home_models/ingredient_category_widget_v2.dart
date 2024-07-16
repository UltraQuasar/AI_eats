import 'package:ai_eats/prompt_model/cuisines_service.dart';
import 'package:flutter/material.dart';

class IngredientCategoryV2 extends StatelessWidget {
  final String type;
  final String path;

  const IngredientCategoryV2(this.type, this.path);



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      customBorder:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      onTap: () {
        print('Navigated to $type');
      },
      child: Container(
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            // light shadow at the bottom
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
                  'assets/icons/food_groups/$path',
                  fit: BoxFit.cover,
                )),
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.black26),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(type,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
