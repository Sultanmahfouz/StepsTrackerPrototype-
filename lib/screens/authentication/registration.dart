import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:steps_tracker_prototype/components/constants.dart';
import 'package:steps_tracker_prototype/screens/authentication/login.dart';
import 'package:steps_tracker_prototype/services/auth.dart';
import '../user_info.dart';
import 'components/button.dart';

class Registeration extends StatefulWidget {
  @override
  _RegisterationState createState() => _RegisterationState();
}

class _RegisterationState extends State<Registeration> {
  String email;
  String password;
  String error = '';
  bool showSpinner = false;
  final _formkey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 200, left: 25),
                  child: Text(
                    'Sign Up',
                    style: textHeaderStyle,
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 40, left: 25, right: 25, bottom: 40),
                  child: Form(
                    key: _formkey,
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
                      ],
                    ),
                  ),
                ),
                Center(
                  child: AuthButton(
                    onPressed: () {
                      if (_formkey.currentState.validate()) {
                        setState(() {
                          showSpinner = true;
                        });
                        dynamic result = _auth.signUpWithEmailAndPassword(
                          email,
                          password,
                          '', // name and image are not required from the user at this stage
                          '',
                        );

                        if (result == null) {
                          setState(() {
                            error = 'Please enter a valid email or password';
                          });
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => GetInfo()),
                          );
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      }
                    },
                    title: 'SIGN UP',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Text(
                        'sign in',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    error,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
