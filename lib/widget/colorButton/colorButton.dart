import 'package:flutter/material.dart';

class ColorButton extends StatelessWidget {
  final bool buttonColor;
  final Color textColor;
  final String text;
  final Function function;
  const ColorButton({Key? key,
    required this.buttonColor,
    required this.textColor,
    required this.text,
    required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    double area = (screenHeight*screenWidth)/20000;

    return Container(
      height: screenHeight*0.055,
      width: screenWidth*0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: buttonColor ? const Color(0XFF03C244):const Color(0xFFFFFFFF),
        border: Border.all(
          color: const Color(0XFF03C244),
        ),
      ),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 5.0),
          ),
        ),
        onPressed: () {
          function();
        },
        child: Text(
          text,
          style: TextStyle(
              fontSize: area,
              fontWeight: FontWeight.normal,
              color: buttonColor ? const Color(0xFFFFFFFF):const Color(0XFF03C244)
          ),
        ),
      ),
    );
  }
}
