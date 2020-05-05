
import 'package:course_app/services/auth.dart';
import 'package:course_app/views/home_screen.dart';
import 'package:course_app/views/signin.dart';
import 'package:course_app/views/signup.dart';
import 'package:course_app/widgets/provider_widget.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Course App',
        theme: ThemeData(),
//        theme: ThemeData(
//              appBarTheme: AppBarTheme(
//                color: Color.fromARGB(200, 255, 255, 255),
//              )),
        home: SignUP(authFormType: AuthFormType.signIn),
        routes: <String, WidgetBuilder>{
          '/signin':(BuildContext context) => SignUP(authFormType: AuthFormType.signIn),
          '/signup':(BuildContext context) => SignUP(authFormType: AuthFormType.signUp),
          '/home': (BuildContext context) => HomeController(),
        }
      ),
    );
  }
}

class HomeController extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;

    // TODO: implement build
    return StreamBuilder(
        stream: auth.onAuthStateChanged,

        builder: (context, AsyncSnapshot<String> snapshot){
          if(snapshot.connectionState == ConnectionState.active){
            final bool signedin = snapshot.hasData;
            return signedin ? HomeScreen(): SignIn(authFormType: AuthFormType.signIn);
          }
          return CircularProgressIndicator();
        },
    );
  }
}

//class Provider extends InheritedWidget{
//  final AuthService auth;
//  Provider({Key key, Widget child, this.auth,}): super(key: key, child: child);
//
//  @override
//  bool updateShouldNotify(InheritedWidget oldWidget) {
//    // TODO: implement updateShouldNotify
//    return true;
//  }
//    static Provider of(BuildContext context)=> (context.inheritFromWidgetOfExactType(Provider)as Provider);
//}
