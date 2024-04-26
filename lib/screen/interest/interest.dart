import 'package:flutter/material.dart';
// import 'package:travelup/screen/home/home.dart';
// import 'package:travelup/variables.dart';
// import 'package:google_fonts/google_fonts.dart';
 import 'package:ecomm/widget/root/root.dart';

import 'package:ecomm/widget/colorButton/colorButton.dart';


class Interest extends StatefulWidget {
  const Interest({Key? key}) : super(key: key);

  @override
  State<Interest> createState() => _InterestState();
}

class _InterestState extends State<Interest> {



  List<String> selectedTagList = [];

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    double area = (screenHeight*screenWidth)/20000;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth*0.09),
              height: screenHeight*0.45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  SizedBox(height: screenHeight*0.03,),
                  Text(
                    "Tell us what you are interested in",
                    style: TextStyle(
                      fontFamily: "Figtree",
                      fontSize: area*(1.7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight*0.02,),
                  Container(
                    height: screenHeight*(0.26),
                    width: screenWidth*0.95,
                    // child: MultiSelectChip(tagList),
                  ),
                  SizedBox(height: screenHeight*0.01,),
                  ColorButton(
                    buttonColor: true,
                    textColor: const Color(0xFFFFFFFF),
                    text: "Done",
                    function: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => const Root()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MultiSelectChip extends StatefulWidget {
  final List<String> tagList;
  final Function(List<String>) onSelectionChanged;
  final Function(List<String>) onMaxSelected;
  final int maxSelection;

  MultiSelectChip(
      this.tagList,
      {this.onSelectionChanged = _defaultOnSelectionChanged,
        this.onMaxSelected = _defaultOnMaxSelected,
        this.maxSelection = 20});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();

  static void _defaultOnSelectionChanged(List<String> selectedChoices) {
    // Do nothing by default
  }
  static void _defaultOnMaxSelected(List<String> selectedChoices) {
    // Do nothing by default
  }
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  // String selectedChoice = "";
  List<String> selectedChoices = [];

  _buildChoiceList() {
    List<Widget> choices = [];
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    double area = (screenHeight*screenWidth)/20000;
    widget.tagList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          margin: EdgeInsets.all(area*(0.09)),
          height: screenWidth*0.1,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(18.0,),
          ),
          child: ChoiceChip(
            backgroundColor: Colors.white,
            selectedColor: Color.fromARGB(255, 196, 252, 198),
            label: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item,
                style: TextStyle(
                  fontSize: area*(1.1),
                ),
              ),
            ),
            selected: selectedChoices.contains(item),
            onSelected: (selected) {
              if(selectedChoices.length == (widget.maxSelection) && !selectedChoices.contains(item)) {
                widget.onMaxSelected.call(selectedChoices);
              } else {
                setState(() {
                  selectedChoices.contains(item)
                      ? selectedChoices.remove(item)
                      : selectedChoices.add(item);
                  widget.onSelectionChanged.call(selectedChoices);
                });
              }
            },
          ),
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
