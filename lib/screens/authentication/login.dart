import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:steps_tracker_prototype/components/constants.dart';
import 'package:steps_tracker_prototype/screens/authentication/registration.dart';
import 'package:steps_tracker_prototype/screens/user_info.dart';
import 'package:steps_tracker_prototype/services/auth.dart';

import 'components/button.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email;
  String password;
  bool showSpinner = false;
  AuthService _auth = AuthService();
  String error = '';

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: decorationLayout,
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 200, left: 25),
                    child: Text(
                      'Sign in',
                      style: textHeaderStyle,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 40, left: 25, right: 25, bottom: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          validator: (value) =>
                              value.isEmpty ? 'Enter a valid email' : null,
                          style: TextStyle(color: primaryColor),
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: fieldDecoration,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) => value.length < 6
                              ? 'Enter a valid password more than 6 characters'
                              : null,
                          style: TextStyle(color: primaryColor),
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          obscureText: true,
                          decoration: fieldDecoration.copyWith(
                              labelText: 'Password',
                              prefixIcon: Icon(
                                Icons.lock,
                                color: primaryColor,
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Forgot password',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Registeration(),
                                  ),
                                );
                              },
                              child: Text(
                                'Create an account?',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: AuthButton(
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email, password);

                            if (user != null) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => GetInfo()));
                            } else {
                              setState(() {
                                error =
                                    'Please enter a valid email or password';
                              });
                            }
                          } catch (error) {
                            print(error.toString());
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        }
                      },
                      title: 'Login',
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        print('Join as a guest');
                      },
                      child: Text(
                        'Join as a guest ----> ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
