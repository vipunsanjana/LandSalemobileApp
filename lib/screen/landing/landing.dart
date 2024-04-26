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
                      image: AssetImage('asset/image/travel.png'),
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
                      height: screenHeight*0.05,
                      width: screenWidth*0.37,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('asset/icon/travelup.png'),
                            fit: BoxFit.fill
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight*0.09,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      height: screenHeight*0.11,
                      width: screenWidth*0.9,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Find anywhere Houses',
                              style: TextStyle(
                                //fontFamily: "Figtree",
                                fontSize: area*(1.34),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'without hassle',
                              style: TextStyle(
                                //fontFamily: "Figtree",
                                fontSize: area*(1.6),
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


