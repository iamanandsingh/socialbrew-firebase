import 'package:flutter/material.dart';
import 'package:testflutter/screen/authenticate/register.dart';
import 'package:testflutter/screen/authenticate/sign_in.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool showsignIn=true;

  void toogle(){
    setState(()=>showsignIn=!showsignIn);
  }

  @override
  Widget build(BuildContext context) {
    if(showsignIn==true)
    {
      return Signin(toogleview:toogle);
    }
    else
    {
      return Register(toogleview:toogle);
    }
  }
}