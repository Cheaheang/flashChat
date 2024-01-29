import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String? email;
  String? password;
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 48.0,
              ),
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                        
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextField.copyWith(hintText: 'Enter your Email')
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextField.copyWith(hintText: 'Enter your Password')
              ),
              SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () async{
                      setState(() {
                        loading= true;
                      });
                   try{
                    final user = await  _auth.createUserWithEmailAndPassword(email: email.toString(), password: password.toString());
                       if(user != null){
                        Navigator.pushNamed(context, ChatScreen.id);
                       }
                       setState(() {
                         loading = false;
                       });
                   }catch(e){
                    print(e);
                   }
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
