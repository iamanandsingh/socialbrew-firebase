import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testflutter/model/user.dart';
import 'package:testflutter/service/database.dart';
import 'package:testflutter/shared/loading.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ["0", "1", "2", "3", "4"];

  //form values
  String _currentname;
  String _currentsugars;
  int _currentstrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<Userdata>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            Userdata userdata=snapshot.data;
            return Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Text(
                    "Update your brew Settings",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    initialValue: userdata.name,
                    validator: (val) => val.isEmpty ? "Enter name" : null,
                    onChanged: (val) {
                      setState(() {
                        _currentname = val;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Enter name",
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField(
                    value: _currentsugars ?? userdata.sugar,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text("$sugar sugars"),
                      );
                    }).toList(),
                    onChanged: (val) => setState(
                      () => _currentsugars = val,
                    ),
                  ),
                  SizedBox(height: 10),
                  Slider.adaptive(
                    value: (_currentstrength ?? userdata.strength).toDouble(),
                    min: 100,
                    max: 900.0,
                    divisions: 8,
                    label: _currentstrength.toString(),
                    activeColor: Colors.brown[_currentstrength ?? userdata.strength],
                    inactiveColor: Colors.brown[_currentstrength ?? userdata.strength],
                    onChanged: (val) {
                      setState(() {
                        _currentstrength = val.round();
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  RaisedButton(
                      color: Colors.black,
                      child: Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {

                        if(_formkey.currentState.validate())
                        {
                          await DatabaseService(uid:user.uid).updateuserdata(_currentsugars??userdata.sugar, _currentname??userdata.name, _currentstrength??userdata.strength);
                        }
                        Navigator.pop(context);
                      
                      }),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
