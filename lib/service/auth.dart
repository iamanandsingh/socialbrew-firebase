import 'package:firebase_auth/firebase_auth.dart';
import 'package:testflutter/model/user.dart';
import 'package:testflutter/service/database.dart';

class AuthService{
  final FirebaseAuth _auth= FirebaseAuth.instance;

//create user object based on firebase user

User _userfirebase(FirebaseUser user)
{
  return user!=null?User(uid:user.uid):null;
}
  
//auth change in user stream

Stream<User> get streamuser
{
  return _auth.onAuthStateChanged.map(_userfirebase);
}


  //sign in with email
  Future signinwithemailpassword(String email,String password) async{
    try{
      AuthResult result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;
      return _userfirebase(user);

    }catch(e){
      print(e.toString());
      return null;

    }
  }
  //register with email and pass

  Future registerwithemailpassword(String email,String password) async{
    try{
      AuthResult result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;
      await DatabaseService(uid:user.uid).updateuserdata("0", "new user", 100);

      return _userfirebase(user);

    }catch(e){
      print(e.toString());
      return null;

    }
  }
  //sign out
  Future signOut ()async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return 0;
    }
  }
}