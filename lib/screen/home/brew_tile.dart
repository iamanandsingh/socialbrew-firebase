import 'package:flutter/material.dart';
import 'package:testflutter/model/brew.dart';

class BrewTile extends StatelessWidget {

  final Brew brew;
  BrewTile({this.brew});
  @override
  Widget build(BuildContext context) {
    return Card(
      child:ListTile(
        leading:CircleAvatar(
          radius:25,
          backgroundColor: Colors.brown[brew.strength],
          backgroundImage: AssetImage("images/coffee_icon.png"),
        ),
        title: Text(brew.name),
        subtitle: Text("Take ${brew.sugar} sugar(s)"),
      ),
    );
  }
}