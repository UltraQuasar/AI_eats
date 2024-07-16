
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../prompt_model/prompt_content.dart';


class InterestOption extends StatefulWidget {
  final String typeTmp;
  final String pathTmp;
  const InterestOption({super.key, required this.typeTmp, required this.pathTmp});



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InterestOptionState();
  }

}

class _InterestOptionState extends State<InterestOption> {
  late String type;
  late String path;
  late InterestOption elm;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    type = widget.typeTmp;
    path = widget.pathTmp;
    elm = widget;
  }
  @override
  Widget build(BuildContext context) {
    final PromptGeneration currentSelected =
        Provider.of<PromptGeneration>(context);
    // TODO: implement build
    return IntrinsicWidth( // adjusts to the width of the content
      child: SizedBox(
        height: 45,
        child: OutlinedButton(
            onPressed: () {
              print('Following preference "${elm.typeTmp}" is selected');
              setState(() {
                currentSelected.selectPreferences(elm, !currentSelected.isSelectedPreferences[elm]!);
              });
            },
            style: OutlinedButton.styleFrom(
              // changes color when it is selected
              side:  BorderSide(color: currentSelected.isSelectedPreferences[elm]! ? Colors.lightGreen : Theme.of(context).primaryColor, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(8.0), // Optionale abgerundete Ecken
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      // puts the image in a box with round edges
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset('assets/icons/preferences/$path', fit: BoxFit.cover,)),
                    ),
                    // when its selected a green overlay over the image is displayed
                    if (currentSelected.isSelectedPreferences[elm]!)
                      Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                              color: Colors.lightGreen.withOpacity(0.4)
                          ),
                          child:  Center(
                            child: Icon(Icons.check, color: Theme.of(context).primaryColor,),
                          ),
                        ),
                  ],
                ),
                Text( // type of the interest
                  type,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
        ),
      ),
    );
  }

}



