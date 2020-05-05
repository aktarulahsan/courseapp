import 'package:auto_size_text/auto_size_text.dart';
import 'package:course_app/animation/FadeAnimation.dart';
import 'package:course_app/services/auth.dart';

import 'package:course_app/views/signin.dart';

//import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:course_app/widgets/provider_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum AuthFormType { signIn, signUp, reset }

final primaryColor = const Color(0xFF75A2EA);

class SignUP extends StatefulWidget {
//  String _email, _password, _name;
  final formKey = GlobalKey<FormState>();

  final AuthFormType authFormType;

  SignUP({Key key, @required this.authFormType}) : super(key: key);

  @override
  _SignUpViewState createState() =>
      _SignUpViewState(authFormType: this.authFormType);
}

class _SignUpViewState extends State<SignUP> {
  AuthFormType authFormType;
  String _title;

  _SignUpViewState({this.authFormType});

  final formKey = GlobalKey<FormState>();
  String _email, _password, _name, _warning;

  void switchFormState(String state) {
    formKey.currentState.reset();
    if (state == "signUp") {
      setState(() {
        _title = "Sign Up";
        authFormType = AuthFormType.signUp;
      });
    } else if (state == "reset") {
      setState(() {
        _title = "reset";
        authFormType = AuthFormType.reset;
      });
    } else {
      setState(() {
        _title = "Sign In";
        authFormType = AuthFormType.signIn;
      });
    }
  }

  bool validate() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void submit() async {
    if (validate()) {
      try {
        final auth = Provider.of(context).auth;
        if (authFormType == AuthFormType.signIn) {
          String uid = await auth.signinWithEmailAndPassword(_email, _password);
          print("Signed In with ID $uid");
          Navigator.of(context).pushReplacementNamed('/home');
        } else if (authFormType == AuthFormType.reset) {
          await auth.sendPasswordResetEmail(_email);
          print("Password reset email send");
          _warning = "A Password reset link has been sent to $_email";
          setState(() {
            authFormType = AuthFormType.signIn;
          });
        } else {
          String uid = await auth.createUserWithEmailAndPassword(
              _email, _password, _name);
          print("Signed up with New ID $uid");
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } catch (e) {
        print(e);
        setState(() {
          _warning = e.message;
        });
      }
    }
  }

  Widget showAlert() {
    if (_warning != null) {
//       Fluttertoast.showToast(
//          msg: _warning,
//          toastLength: Toast.LENGTH_SHORT,
//          gravity: ToastGravity.CENTER,
//          timeInSecForIosWeb: 1,
//          backgroundColor: Colors.red,
//          textColor: Colors.white,
//          fontSize: 16.0
//      );

      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(
                _warning,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _warning = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
//                SizedBox(height: _height * 0.025),
                showAlert(),
//                SizedBox(height: _height * 0.025),
                Container(
                  height: 350,
//                  showAlert(),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: FadeAnimation(
                            1,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-1.png'))),
                            )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.3,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-2.png'))),
                            )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.5,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/clock.png'))),
                            )),
                      ),
                      Positioned(
                        child: FadeAnimation(
                            1.6,
                            Container(
//                                buildHeaderText(),
                              margin: EdgeInsets.only(top: 50),
                              child: Center(
                                child: buildHeaderText(),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                          1.8,
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[100]))),
//                                  child: TextField(
//                                    decoration: InputDecoration(
//                                        border: InputBorder.none,
//                                        hintText: "User Name",
//                                        hintStyle:
//                                        TextStyle(color: Colors.grey[400])),
//                                    onSubmitted: (text) {
//                                      _name = text;
//                                    },
//
//                                  ),
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      children: buildInputs(),
                                    ),
                                  ),
                                ),
//                                Container(
//                                  padding: EdgeInsets.all(8.0),
//                                  decoration: BoxDecoration(
//                                      border: Border(
//                                          bottom: BorderSide(
//                                              color: Colors.grey[100]))),
//                                  child: TextField(
//                                    decoration: InputDecoration(
//                                        border: InputBorder.none,
//                                        hintText: "Email or Phone number",
//                                        hintStyle:
//                                            TextStyle(color: Colors.grey[400])),
//                                    onSubmitted: (text) {
//                                      _email = text;
//                                    },
//                                  ),
//                                ),
//                                Container(
//                                  padding: EdgeInsets.all(8.0),
//                                  child: TextField(
//                                    decoration: InputDecoration(
//                                        border: InputBorder.none,
//                                        hintText: "Password",
//                                        hintStyle:
//                                        TextStyle(color: Colors.grey[400])),
//                                    onSubmitted: (text) {
//                                      _password = text;
//                                    },
//
//                                  ),
//                                ),
                              ],
                            ),
                          )),
//                      FadeAnimation(
//                        3,
//                        Container(
//                          height: 50,
//                          child: Center(
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.end,
//                              children: <Widget>[
//                                FlatButton(
//                                  child: Text('Sign in',style: TextStyle(color: Colors.black,  fontWeight: FontWeight.bold)),
//                                  onPressed: () {
//                                    Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                          builder: (context) => SignIn(authFormType: AuthFormType.signIn)),
//                                    );
//                                  },
//                                )
//                              ],
//                            ),
//                            // child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
//                          ),
//                        ),
//                      ),
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                          2,
                          Container(
                            child: Column(
                              children: buildButtons(),
                            ),
                          )),
//                      SizedBox(
//                        height: 70,
//                      ),
//                      FadeAnimation(
//                          1.5,
//                          Text(
//                            "Forgot Password?",
//                            style: TextStyle(
//                                color: Color.fromRGBO(143, 148, 251, 1)),
//                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  AutoSizeText buildHeaderText() {
    String _headerText;
    if (authFormType == AuthFormType.signUp) {
      _headerText = "Create New Account";
    } else if (authFormType == AuthFormType.reset) {
      _headerText = "Reset Password";
    } else {
      _headerText = "Sign In";
    }
    return AutoSizeText(
      _headerText,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 35,
        color: Colors.white,
      ),
    );
  }

  List<Widget> buildInputs() {
    List<Widget> textFields = [];

    if (authFormType == AuthFormType.reset) {
      textFields.add(
        TextFormField(
          validator: EmailValidator.validate,
          style: TextStyle(fontSize: 16.0),
          decoration: buildSignUpInputDecoration("Email"),
          onSaved: (value) => _email = value,
        ),
      );
      textFields.add(SizedBox(height: 10));
      return textFields;
    }

    // if were in the sign up state add name
    if (authFormType == AuthFormType.signUp) {
      textFields.add(
        TextFormField(
          validator: NameValidator.validate,
          style: TextStyle(fontSize: 16.0),
          decoration: buildSignUpInputDecoration("Name"),
          onSaved: (value) => _name = value,
        ),
      );
      textFields.add(SizedBox(height: 20));
    }

    // add email & password
    textFields.add(
      TextFormField(
        validator: EmailValidator.validate,
        style: TextStyle(fontSize: 16.0),
        decoration: buildSignUpInputDecoration("Email"),
        onSaved: (value) => _email = value,
      ),
    );
    textFields.add(SizedBox(height: 20));
    textFields.add(
      TextFormField(
        validator: PasswordValidator.validate,
        style: TextStyle(fontSize: 16.0),
        decoration: buildSignUpInputDecoration("Password"),
        obscureText: true,
        onSaved: (value) => _password = value,
      ),
    );
    textFields.add(SizedBox(height: 20));

    return textFields;
  }

  InputDecoration buildSignUpInputDecoration(String hint) {
    return InputDecoration(
//        focusedBorder: OutlineInputBorder(
//          borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
//        ),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400]));
  }

  List<Widget> buildButtons() {
    String _switchButtonText, _newFormState, _submitButtonText;
    bool _showForgotPassword = false;

    if (authFormType == AuthFormType.signIn) {
      _switchButtonText = "Create New Account";
      _newFormState = "signUp";
      _submitButtonText = "Sign In";
      _showForgotPassword = true;
    } else if (authFormType == AuthFormType.reset) {
      _switchButtonText = "Return to Sign In";
      _newFormState = "signIn";
      _submitButtonText = "Submit";
    } else {
      _switchButtonText = "Have an Account? Sign In";
      _newFormState = "signIn";
      _submitButtonText = "Sign Up";
    }

    return [
      Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(143, 148, 251, 1),
              Color.fromRGBO(143, 148, 251, .6),
            ])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                textColor: Colors.white,
                child: Text(_submitButtonText),
                onPressed: submit,
              ),
            ],
          ),
          // child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        ),
      ),
      showForgotPassword(_showForgotPassword),
      FlatButton(
        child: Text(
          _switchButtonText,
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () {
          switchFormState(_newFormState);
        },
      )
    ];
  }

  Widget showForgotPassword(bool visible) {
    return Visibility(
      child: FlatButton(
        child: Text(
          "Forgot Password?",
          style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),
        ),
        onPressed: () {
          setState(() {
            authFormType = AuthFormType.reset;
          });
        },
      ),
      visible: visible,
    );
  }
}
