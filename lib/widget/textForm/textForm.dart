import 'dart:ui';

import 'package:flutter/material.dart';

class TextForm extends StatefulWidget {

  final TextEditingController input;
  final IconData icon;
  final bool value;
  final String text;

  const TextForm({Key? key,
    required this.input,
    required this.icon,
    required this.value,
    required this.text,}) : super(key: key);

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  bool isPressing = false;
  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    double area = (screenHeight*screenWidth)/20000;

    return Container(
      width: screenWidth*0.95,
      child: Column(
        children: <Widget>[
          Container(
            height: screenHeight*0.065,
            child: TextField(
              style: TextStyle(
                  fontSize: area*(20/17),
                  color: Color.fromARGB(255, 0, 0, 0)
              ),
              controller: widget.input,
              obscureText: !isPressing ? widget.value : false,
              decoration: InputDecoration(
                labelText: widget.text,
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 175, 176, 175),
                  fontSize: area,
                  //fontWeight: FontWeight.bold,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    !isPressing ? widget.icon : Icons.visibility,
                    color: Color.fromARGB(255, 2, 206, 53),
                  ),
                  onPressed:() {
                    setState(() {
                      isPressing = !isPressing;
                    }
                    );
                  },
                ),
                fillColor: const Color.fromARGB(255, 222, 255, 223) ,
                filled: true,
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0),width: 1.0),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 10, 10, 10),width: 1.0),
                ),
              ),
            ),
          ),
          Container(
            width: screenWidth*0.95,
            height: widget.value? screenHeight*0.043:10.0,
            padding: const EdgeInsets.symmetric(vertical: 5.0,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                widget.value? Text(
                  'Forgot password',
                  style: TextStyle(
                    fontSize: area*(16/17),
                    color: Color.fromARGB(255, 152, 152, 152),
                    //fontWeight: FontWeight.bold,
                  ),
                ):const Text(''),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

