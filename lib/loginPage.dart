import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;

  void validateSave() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("login"),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              icon: const Icon(Icons.person),
                              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 5.0),
                ),
              labelText: "Email"),
            onChanged: (value) {
              setState(() {
                _email = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: const Icon(Icons.vpn_key),
              hintText: "Password",
              labelText: "Password"
              ),
            onChanged: (value) {
              setState(() {
                _password = value;
              });
            },
            obscureText: true,
          ),
          RaisedButton(
            child: Text(
              "Log In",
              style: TextStyle(fontSize: 20.0),
            ),
            onPressed: () {
              FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: _email, password: _password)
                  .then((user) {
                Navigator.of(context).pushReplacementNamed('/homepage');
              }).catchError((e) {
                print(e);
              });
            },
            color: Colors.green,
          ),
          RaisedButton(
            child: Text(
              "Sign UP",
              style: TextStyle(fontSize: 20.0),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/signup');
            },
            color: Colors.green,
          )
            ],
          ),
        ));
  }
}
