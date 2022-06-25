import 'package:flash_chat/screens/registration_screen.dart';
import 'login_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/buttons.dart';

class WelcomeScreen extends StatefulWidget {
  static final String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  //add ticker to screenstate for controller
  late AnimationController controller; //create animation controller variable
  late Animation animation; //curved animation
  late Animation textAnimation;
  @override
  void initState() {
    super.initState();
    //Controller - vysnc this (this widgets state) - upperBound (top int value of animation)
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    controller.forward(); //command the controllor forward

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    textAnimation =
        ColorTween(begin: Colors.grey, end: Colors.black).animate(controller);

    controller.addListener(() {
      //listen for init and setState. print optional
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  //Hero Animation
                  tag: 'logo', //Tag
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60, //size animates to controller value
                  ),
                ),
                TypewriterAnimatedTextKit(
                  repeatForever: false,
                  speed: Duration(milliseconds: 200),
                  text: ['Flash Chat'],
                  textStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Button(
                text: 'Log In',
                color: Colors.lightBlueAccent,
                route: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                }),
            Button(
                text: 'Register',
                color: Colors.lightBlue,
                route: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                }),
          ],
        ),
      ),
    );
  }
}
