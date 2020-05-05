import 'package:course_app/animation/FadeAnimation.dart';

import 'package:course_app/views/signup.dart';
import 'package:course_app/widgets/provider_widget.dart';
//import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignIn extends StatelessWidget {
  var userid;
  var password;
  String _email, _password;
  final formKey = GlobalKey<FormState>();
//  bool validateEmail(String value) {
//    Pattern pattern =
//        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//    RegExp regex = new RegExp(pattern);
//    return (!regex.hasMatch(value)) ? false : true;
//  }
  final AuthFormType authFormType;
  SignIn({Key key, @required this.authFormType}) : super(key: key);



  @override
  Widget build(BuildContext context) {

//    String _email, _password;

    void submit() async {
      final form = formKey.currentState;
      form.save();



      try {
        final auth = Provider.of(context).auth;
//      if(authFormType == AuthFormType.signIn) {
        if(_email.isEmpty){
          Fluttertoast.showToast(
              msg: "Please Input Valid Email",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          return;
        }else if(_password.isEmpty  || _password.length <6){
          Fluttertoast.showToast(
              msg: "Please Input minimum 6 digit passwords",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          return;
        }
        String uid = await auth.signinWithEmailAndPassword(_email, _password);
        print("Signed In with ID $uid");
        Navigator.of(context).pushReplacementNamed('/home');
//      } else {
//      String uid = await auth.createUserWithEmailAndPassword(_email, _password, _name);
//      print("Signed up with New ID $uid");
//      Navigator.of(context).pushReplacementNamed('/home');
//      }
      } catch (e) {
        Fluttertoast.showToast(
            msg: e,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        print("error is "+e);
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
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
                              margin: EdgeInsets.only(top: 50),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
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
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      children: buildInputs(),
                                    ),
                                  ),


//                                  child: TextFormField(
//                                    decoration: InputDecoration(
//                                        border: InputBorder.none,
//                                        hintText: "Email or Phone number",
//                                        hintStyle:
//                                            TextStyle(color: Colors.grey[400])),
//                                    onSaved: (value) => _email = value,
//                                  ),
                                ),
//                                Container(
//                                  padding: EdgeInsets.all(8.0),
//                                  child: TextFormField(
//                                    decoration: InputDecoration(
//                                        border: InputBorder.none,
//                                        hintText: "Password",
//                                        hintStyle:
//                                            TextStyle(color: Colors.grey[400])),
//                                    onSaved: (value) => _password = value,
//                                  ),
//                                )
                              ],
                            ),
                          )),
                      FadeAnimation(
                        3,
                        Container(
                          height: 50,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                FlatButton(
                                  child: Text('Sign Up',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SignUP(authFormType: null)),
                                    );
                                  },
                                )
                              ],
                            ),
                            // child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                          2,
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
                                    child: Text('Login'),
                                    onPressed: submit,
//                                    onPressed: () {
//                                      print(userid + password);
//                                      Route route = MaterialPageRoute(
//                                          builder: (context) => HomeScreen());
//                                      Navigator.push(context, route);
//                                    },
                                  )
                                ],
                              ),
                              // child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ),
                          )),
                      SizedBox(
                        height: 70,
                      ),
                      FadeAnimation(
                          1.5,
                          Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Color.fromRGBO(143, 148, 251, 1)),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  List<Widget> buildInputs() {
    List<Widget> textFields = [];

//textFields.add(SizedBox(height: 10));

    textFields.add(

      TextFormField(
        style: TextStyle(fontSize: 16.0,),
        decoration: buildSignUpInputDecoration("Email"),
//        validator: (val) => !EmailValidator.validate(val, true)
//            ? 'Not a valid email.'
//            : null,
        onSaved: (val) => _email = val,
      ),
//      bdecoration:boxDecoration(),
    );
//    textFields.add(SizedBox(height: 15));
    textFields.add(
      TextFormField(
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
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
        ),
//        enabledBorder: OutlineInputBorder(
//          borderSide: BorderSide(color: Colors.red, width: 1.0),
//        ),
//        border: InputBorder.none,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400]));
  }
BoxDecoration boxDecoration(){
  return BoxDecoration(
      border: Border(
          bottom: BorderSide(
              color: Colors.grey[100])),

  );
}

}
