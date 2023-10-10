import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

final _auth = FirebaseAuth.instance;
String? email;
String? password;
bool _isLoading = false;

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        height: 200.0,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your email')),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                      textAlign: TextAlign.center,
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your password')),
                  SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                    onpressed: () async {
                      try {
                        setState(() {
                          _isLoading = true;
                        });
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email!, password: password!);
                        if (newUser.user != null) {
                          Navigator.pushNamed(
                            context,
                            ChatScreen.id,
                          );
                        }
                        setState(() {
                          _isLoading = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    title: 'Register',
                    color: Colors.blueAccent,
                  )
                ],
              ),
              _isLoading
                  ? Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
