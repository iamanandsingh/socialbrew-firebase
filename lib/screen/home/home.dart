import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testflutter/model/brew.dart';
import 'package:testflutter/screen/home/settings_form.dart';
import 'package:testflutter/service/auth.dart';
import 'package:testflutter/service/database.dart';

import 'brew_list.dart';

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();


  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel()
    {
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical:20,horizontal:60),
          child: SettingForm()
        );
      });
    }
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        appBar: AppBar(
          title: Text("HOME"),
          backgroundColor: Colors.brown[900],
          actions: <Widget>[
            Row(children: [
              
              Container(
                decoration: BoxDecoration(
                  color: Colors.brown[200],
                  borderRadius: BorderRadius.circular(50)
                ),
                child: IconButton(
                    icon: Icon(Icons.exit_to_app, color: Colors.brown[900]),
                    onPressed: () async {
                      await _authService.signOut();
                    }),
              ),

              Container(
                
                decoration: BoxDecoration(
                  color: Colors.brown[200],
                  borderRadius: BorderRadius.circular(50)
                ),
                child: IconButton(
                    icon: Icon(Icons.settings, color: Colors.brown[900]),
                    onPressed: () =>_showSettingsPanel()),
              ),
            ]),

          ],
        ),
        body: Container
        (decoration: BoxDecoration(
          image:DecorationImage(
            image:AssetImage("images/coffee_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
          child: BrewList()),
      ),
    );
  }
}
