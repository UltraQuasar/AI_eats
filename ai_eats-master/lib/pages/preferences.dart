import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../preferences_models/appBarPreferences.dart';
import '../preferences_models/button_done.dart';
import '../preferences_models/interest_option.dart';
import '../prompt_model/prompt_content.dart';

class SelectPreferences extends StatefulWidget {
  const SelectPreferences({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SelectPreferencesState();
  }

}


class _SelectPreferencesState extends State<SelectPreferences> {

  Widget _buildColumn(List<InterestOption> p, double h) { // column to select preferences
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate((p.length / 2).ceil(), (index) { // generates a list with two elements in each row
        final firstElm = p[index * 2];
        final secondElm =(index * 2 + 1 < p.length) ? p[index * 2 + 1] : null; // edge case check: if list length is uneven
        return Column(
          children: [
            _buildRow(firstElm, (secondElm != null) ? secondElm : InterestOption(typeTmp: 'null', pathTmp: 'null')), // if uneven-> null object
            SizedBox(height:  h)
          ],
        );
    }
    )
    );
  }

  Widget _buildRow(InterestOption firstElm, InterestOption secElm) { // creates row
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
          firstElm,
        if (secElm.typeTmp != 'null') // checks edge case
          secElm,
        ],
    );
  }
  @override
  Widget build(BuildContext context) {
    List<InterestOption> preferences = context.read<PromptGeneration>().preferences.preferences;
    // TODO: implement build
    const double space = 25.0;
    return Scaffold(
      appBar: appBarPreferences(context),
      body: _buildColumn(preferences, space),
      floatingActionButton: doneButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}