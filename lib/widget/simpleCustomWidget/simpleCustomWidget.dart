import 'package:flutter/material.dart';

class Or extends StatelessWidget {
  const Or({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            indent: screenWidth*0.01,
            endIndent: screenWidth*0.025,
            thickness: 1,
          ),
        ),
        const Text(
          "OR",
          style: TextStyle(
              color: Color.fromARGB(255, 75, 75, 75),
              fontWeight: FontWeight.bold
          ),
        ),
        Expanded(
          child: Divider(
            indent: screenWidth*0.025,
            endIndent: screenWidth*0.01,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String text1;
  final String text2;
  final Function function;
  const CustomTextButton({Key? key,
    required this.text1,
    required this.text2,
    required this.function}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style: const TextStyle(
            fontSize: 16.0,
            color: Color.fromARGB(255, 183, 181, 176),
          ),
        ),
        TextButton(
            onPressed: (){
              function();
            },
            child: Text(
              text2,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.green,
              ),
            )
        )
      ],
    );
  }
}

class FacebookSignInButton extends StatelessWidget {
  const FacebookSignInButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    double area = (screenHeight*screenWidth)/20000;

    return Container(
      height: screenHeight*0.05,
      width: screenWidth*0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color:const Color(0xFFFFFFFF),
        border: Border.all(
          color: Color.fromARGB(255, 229, 229, 229),
          width: 1.3,
        ),
      ),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 3.0),
          ),
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(screenWidth*0.01),
              height: area*(1.2),
              width: area*(1.2),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('asset/icon/facebook.png'),
                    fit: BoxFit.fill
                ),
              ),
            ),
            Text(
              'Continue with Facebook',
              style: TextStyle(
                  fontSize: area*(1.1),
                  fontWeight: FontWeight.normal,
                  color: Color.fromARGB(255, 85, 85, 85)
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    double area = (screenHeight*screenWidth)/20000;

    return Container(
      height: screenHeight*0.05,
      width: screenWidth*0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color:const Color(0xFFFFFFFF),
        border: Border.all(
          color: Color.fromARGB(255, 229, 229, 229),
          width: 1.3,
        ),
      ),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 3.0),
          ),
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(screenWidth*0.01),
              height: area*(1.2),
              width: area*(1.2),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('asset/icon/google.png'),
                    fit: BoxFit.fill
                ),
              ),
            ),
            Text(
              'Continue with Google',
              style: TextStyle(
                  fontSize: area*(1.1),
                  fontWeight: FontWeight.normal,
                  color: Color.fromARGB(255, 85, 85, 85)
              ),
            ),
          ],
        ),
      ),
    );
  }
}