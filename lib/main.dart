import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testflutter/screen/wrapper.dart';
import 'package:testflutter/service/auth.dart';

import 'model/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().streamuser,
          child: MaterialApp(
        home:Wrapper()
        
      ),
    );
  }
}

  