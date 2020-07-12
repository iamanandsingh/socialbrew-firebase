import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testflutter/model/user.dart';
import 'package:testflutter/screen/home/home.dart';

import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    final user=Provider.of<User>(context);
    if(user==null)
    {
      return Auth();
    }
    else
    return Home();
  }
}