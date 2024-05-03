import 'dart:convert';
import 'package:ecomm/screen/adminHome/adminHome.dart';
import 'package:ecomm/screen/home/home.dart';
import 'package:ecomm/screen/interest/interest.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ecomm/screen/SignUp/signUp.dart';
//import 'package:ecomm/screen/interest/interest.dart';
import 'package:ecomm/widget/colorButton/colorButton.dart';
import 'package:ecomm/widget/simpleCustomWidget/simpleCustomWidget.dart';
import 'package:ecomm/widget/textForm/textForm.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController email = TextEditingController();
  TextEditingController passWord = TextEditingController();

  Future<void> loginUser() async {



    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid email')),
      );
      return; // Stop further execution
    }


    if (passWord.text.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password must be at least 4 characters long')),
      );
      return; // Stop further execution
    }



    final String apiUrl = 'http://localhost:3002/api/user/login';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email.text,
        'password': passWord.text,
      }),
    );

    if (response.statusCode == 200) {

      // User logged in successfully
      print("User Logged In Successfully.");
      print(jsonDecode(response.body)['user']['role']);
      final String role = jsonDecode(response.body)['user']['role'];
      // Navigate to next screen or perform desired action
      print(jsonDecode(response.body)['token']);

      role == "user"
          ? Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => Home(
            userId: jsonDecode(response.body)['user']['userId'], // Pass userId to AdminHome screen
            token: jsonDecode(response.body)['token'], // Pass token to AdminHome screen
          ),
        ),
      )
          : Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => AdminHome(
            userId: jsonDecode(response.body)['user']['userId'], // Pass userId to AdminHome screen
            token: jsonDecode(response.body)['token'], // Pass token to AdminHome screen
          ),
        ),
      );


    } else {
      // Error logging in user
      print("Login Error: ${jsonDecode(response.body)['message']}");
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
              top: screenHeight * 0.07,
              left: screenWidth * 0.09,
              right: screenWidth * 0.09),
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
                        fit: BoxFit.fill),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Row(
                  children: [
                    Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: area * (35 / 17),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.06),
                TextForm(
                  input: email,
                  icon: Icons.abc,
                  value: false,
                  text: 'Username',
                ),
                TextForm(
                  input: passWord,
                  icon: Icons.abc,
                  value: true,
                  text: 'Password',
                ),
                SizedBox(height: screenHeight * 0.05),
                ColorButton(
                  buttonColor: true,
                  text: 'Sign In',
                  function: loginUser,
                  textColor: const Color(0xFFFFFFFF),
                ),
                SizedBox(height: screenHeight * 0.09),
                CustomTextButton(
                    text1: "Don't have an account?",
                    text2: "Register",
                    function: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => const SignUp()));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
