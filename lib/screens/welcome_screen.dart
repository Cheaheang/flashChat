import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/welcomeClass/button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  Animation? animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(seconds: 2),
        // upperBound: 100,
        vsync: this);
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    controller.forward();
    // animation?.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse(from: 1.0);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });
    // controll
    controller.addListener(() {
      setState(() {});
      print(controller.value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation?.value ?? 40,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 210.0,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 40.0,
                      color: Colors.black,
                      fontFamily: 'Bobbers',
                      
                    ),
                    child: AnimatedTextKit(
                      
                      animatedTexts: [
                        
                        TypewriterAnimatedText('Flash chat',speed: const Duration(seconds: 1)),
                      ],
                       
                    ),
                  ),
                ),
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: controller.value * 40,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ), 
            RoundedButton(onPress: 
            (){
              Navigator.pushNamed(context, LoginScreen.id);
            }, color: Colors.lightBlueAccent, title: 'Log In',
            ),
            RoundedButton(onPress: 
            (){
              Navigator.pushNamed(context, RegistrationScreen.id);
            }, color: Colors.blueAccent, title: 'Register',
            )
          ],
        ),
      ),
    );
  }
}


 