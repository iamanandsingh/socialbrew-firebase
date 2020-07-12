import 'package:flutter/material.dart';
import 'package:testflutter/service/auth.dart';
import 'package:testflutter/shared/loading.dart';

class Signin extends StatefulWidget {
  final Function toogleview;
  Signin({this.toogleview});
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final AuthService _authService = AuthService();
  final _formkey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String error = "";
bool loading=false;
  @override
  Widget build(BuildContext context) {
    return loading?Loading(): Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[900],
        centerTitle: true,
        title: Text("Login Page"),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              widget.toogleview();
            },
            icon: Icon(Icons.person),
            label: Text("Register"),
          )
        ],
      ),
      body: Stack(fit: StackFit.expand, children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              child: SingleChildScrollView(
                child: Form(
                 key: _formkey,

                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (val) =>
                              val.isEmpty ? "Enter Email" : null,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email Id",
                            hintText: "Enter email",
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          validator: (val) => val.length < 6
                              ? "Enter atleast 6 digit password"
                              : null,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "Enter Password",
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        RaisedButton(
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                setState(() {
                                  loading=true;
                                });
                                dynamic result = await _authService
                                    .signinwithemailpassword(email, password);
                                if (result == null) {
                                  setState(() {
                                    error = "Enter valid email and password";
                                    loading=false;
                                  });
                               }
                               print("valid");
                              }
                            },
                            color: Colors.amber,
                            child: Text("Sign In")),
                        SizedBox(height: 10),
                        Text(error),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
