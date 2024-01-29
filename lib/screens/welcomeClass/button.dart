import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
 
class RoundedButton extends StatelessWidget {
 const RoundedButton({this.title, this.color,required this.onPress});
 final String? title;
 final Color? color;
 final VoidCallback onPress;


  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                
                color: color,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: onPress,
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    title.toString(),
                  ),
                ),
              ),
            );
  }
}