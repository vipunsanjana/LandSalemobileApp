import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ecomm/screen/SignIn/SignIn.dart';
import 'package:ecomm/screen/interest/interest.dart';
import 'package:ecomm/widget/colorButton/colorButton.dart';
import 'package:ecomm/widget/simpleCustomWidget/simpleCustomWidget.dart';
import 'package:ecomm/widget/textForm/textForm.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController passWord1 = TextEditingController();

  Future<void> registerUser() async {
    // Email validation
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid email')),
      );
      return; // Stop further execution
    }

    // Password validation
    if (passWord1.text.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password must be at least 4 characters long')),
      );
      return; // Stop further execution
    }

    // If validations pass, proceed with registration
    final String apiUrl = 'http://localhost:3002/api/user/register';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email.text,
        'password': passWord1.text,
      }),
    );

    if (response.statusCode == 200) {
      // User registered successfully
      SnackBar(content: Text('User Looged Successfully'));
      print("User Registered Successfully.");


      // Navigate to next screen or perform desired action
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => const SignIn(),
      ));
    } else {
      // Error registering user
      print("User Registration Error: ${jsonDecode(response.body)['message']}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User Registration Error: ${jsonDecode(response.body)['message']}')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    double area = (screenHeight * screenWidth) / 20000;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: screenHeight * 0.06,
            left: screenWidth * 0.09,
            right: screenWidth * 0.09,
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: screenHeight * 0.05),
                Container(
                  height: screenHeight * 0.15,
                  width: screenWidth * 0.37,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('asset/icon/IslandHomesLogo.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Row(
                  children: [
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: area * (35 / 17),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                SizedBox(height: screenHeight * 0.01),
                SizedBox(height: screenHeight * 0.02),
                TextForm(
                  input: email,
                  icon: Icons.abc,
                  value: false,
                  text: 'email',
                ),
                TextForm(
                  input: passWord1,
                  icon: Icons.abc,
                  value: true,
                  text: 'Password',
                ),
                SizedBox(height: screenHeight * 0.01),
                ColorButton(
                  buttonColor: true,
                  text: 'Sign Up',
                  function: registerUser,
                  textColor: const Color(0xFFFFFFFF),
                ),
                SizedBox(height: screenHeight * 0.02),
                const Or(),
                SizedBox(height: screenHeight * 0.003),
                CustomTextButton(
                  text1: "Already have an account?",
                  text2: "Sign in",
                  function: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => const SignIn(),
                    ));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
