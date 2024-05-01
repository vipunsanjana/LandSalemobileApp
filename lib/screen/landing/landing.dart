import 'package:ecomm/screen/SignIn/SignIn.dart';
import 'package:ecomm/screen/SignUp/signUp.dart';
import 'package:ecomm/widget/colorButton/colorButton.dart';
import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
              height: screenHeight*0.52,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('asset/image/full.jpg'),
                      fit: BoxFit.fill
                  )
              ),
            ),
            // ignore: sized_box_for_whitespace
            Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth*0.09,),
              height: screenHeight*0.45,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: screenHeight*0.045,),
                    Container(
                      height: screenHeight * 0.08,
                      width: screenWidth * 0.37,
                      child: Center(
                        child: Image.asset(
                          'asset/icon/IslandHomesLogo.png', // Replace 'assets/island_homes_image.png' with the path to your image asset
                          fit: BoxFit.contain, // Adjust the fit as needed
                        ),
                      ),
                    ),


                    SizedBox(height: screenHeight*0.09,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      height: screenHeight*0.09,
                      width: screenWidth*0.9,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Find Houses',
                              style: TextStyle(
                                //fontFamily: "Figtree",
                                fontSize: area*(1.24),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight*0.02),
                    ColorButton(
                      buttonColor: true,
                      text: 'Sign In',
                      function: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => const SignIn()));
                      },
                      textColor: const Color(0xFFFFFFFF),
                    ),
                    SizedBox(height: screenHeight*0.01),
                    ColorButton(
                      buttonColor: false,
                      text: 'Sign Up',
                      function: () {    Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => const SignUp()));},
                      textColor: const Color(0xFFFFFFFF),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


