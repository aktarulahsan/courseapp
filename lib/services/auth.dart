import 'package:firebase_auth/firebase_auth.dart';



class AuthService{

final FirebaseAuth _auth = FirebaseAuth.instance;

Stream<String> get onAuthStateChanged=> _auth.onAuthStateChanged.map(
  (FirebaseUser user)=> user?.uid,
);


// sign anonymous
Future signInAnon() async {
  try {
   AuthResult result =  await _auth.signInAnonymously();
   FirebaseUser user = result.user;
   return user;
  } catch (e) {
    print(e.toString());
    return null;
  }
}

//sign in with email pass

Future<String> createUserWithEmailAndPassword(String email, 
String password,String name) async{
  final currentUser = await _auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
    );

    //update the username
  var userUpdateInfo = UserUpdateInfo();
  userUpdateInfo.displayName = name;
  await currentUser.user.updateProfile(userUpdateInfo);
  await currentUser.user.reload();
  return currentUser.user.uid;
}

    // GET UID
  Future<String> getCurrentUid()async{
  return (await _auth.currentUser()).uid;
  }
    // get current user
  Future getCurrentUser()async{
  return await _auth.currentUser();
  }

//email & password sign in 

Future<String> signinWithEmailAndPassword(String email, String password) async{
  return(await _auth.signInWithEmailAndPassword(email: email, password: password)).user.uid;

}
//  Future<String> signInWithEmailAndPassword(
//      String email, String password) async {
//    return (await _auth.signInWithEmailAndPassword(
//        email: email, password: password))
//        .uid;
//  }


// Sign out

  signOut(){
      return _auth.signOut();

  }
  Future sendPasswordResetEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

}
class NameValidator {
  static String validate(String value) {
    if(value.isEmpty) {
      return "Name can't be empty";
    }
    if(value.length < 2) {
      return "Name must be at least 2 characters long";
    }
    if(value.length > 50) {
      return "Name must be less than 50 characters long";
    }
    return null;
  }
}


class EmailValidator{
  static String validate(String value){
    if(value.isEmpty){
      return "Email can't be Empty";
    }
    return null;
  }
}

class PasswordValidator {
  static String validate(String value) {
    if(value.isEmpty) {
      return "Password can't be empty";
    }
    return null;
  }
}