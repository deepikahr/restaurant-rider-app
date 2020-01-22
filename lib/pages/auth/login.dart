import 'dart:io';
import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:delivery_app/pages/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/auth-service.dart';
import '../../services/common.dart';

class Login extends StatefulWidget {
  static String tag = 'login-page';
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  String email, password;
  bool loading = false;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffKey = GlobalKey<ScaffoldState>();

  login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      Map<String, dynamic> body = {
        'email': email,
        'password': password,
      };
      setState(() {
        loading = true;
      });
      AuthService.login(
        body,
      ).then((onValue) {
        prefs.setString("token", onValue['token']);
        if (onValue['message'] != null) {}

        if (onValue['token'] != null) {
          Common.setToken(onValue['token']).then((saved) {
            if (saved) {
              Future.delayed(Duration(milliseconds: 1500), () {
                Navigator.of(context).pop();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(),
                  ),
                );
              });
            }
          });
        }
      }).catchError((onError) {
        setState(() {
          loading = false;
        });
      });
    } else {
      setState(() {
        loading = false;
      });
      return;
    }
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => exit(0),
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
            backgroundColor: Colors.white,
            body: new Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Center(
                  child: new SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 30.0),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 50.0),
                        ),
                        Container(
                          height: 120.0,
                          child: new Image(
                            image: new AssetImage("assets/imgs/logo.png"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                        ),
                        new Form(
                          key: _formkey,
                          child: new Theme(
                            data: new ThemeData(
                              brightness: Brightness.dark,
                              accentColor: Colors.black,
                              inputDecorationTheme: new InputDecorationTheme(
                                labelStyle: new TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                  padding: const EdgeInsets.all(5.0),
                                  margin: const EdgeInsets.all(5.0),
                                  decoration: new BoxDecoration(
                                    border: new Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius: new BorderRadius.all(
                                        Radius.circular(5.0)),
                                  ),
                                  alignment: FractionalOffset.center,
                                  child: new TextFormField(
                                    initialValue: "staff1@ionicfirebaseapp.com",
                                    style: TextStyle(color: Colors.black),
                                    decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Employee ID',
                                        hintStyle: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.0,
                                        ),
                                        icon: new Icon(
                                          Icons.email,
                                          color: Colors.black,
                                        )),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (String value) {
                                      if (value.isEmpty ||
                                          !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                              .hasMatch(value)) {
                                        return 'Please enter a valid email';
                                      }
                                    },
                                    onSaved: (String value) {
                                      email = value;
                                    },
                                  ),
                                ),
                                new Container(
                                  padding: const EdgeInsets.all(5.0),
                                  margin: const EdgeInsets.all(5.0),
                                  decoration: new BoxDecoration(
                                    border: new Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius: new BorderRadius.all(
                                        Radius.circular(5.0)),
                                  ),
                                  alignment: FractionalOffset.center,
                                  child: new TextFormField(
                                    initialValue: "123456",
                                    style: TextStyle(color: Colors.black),
                                    decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.0,
                                      ),
                                      icon: new Icon(Icons.lock,
                                          color: Colors.black),
                                    ),
                                    keyboardType: TextInputType.text,

                                    validator: (String value) {
                                      if (value.isEmpty || value.length < 6) {
                                        return 'Password invalid';
                                      }
                                    },
                                    // controller: _passwordTextController,
                                    onSaved: (String value) {
                                      password = value;
                                    },
                                    obscureText: true,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 15.0),
                                  width: 285.0,
                                  decoration: BoxDecoration(
                                    color: primary,
                                    borderRadius: new BorderRadius.all(
                                        Radius.circular(5.0)),
                                  ),
                                  child: RawMaterialButton(
                                    onPressed: login,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "LOGIN TO YOUR ACCOUNT",
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 5.0, right: 5.0)),
                                        loading
                                            ? Image.asset(
                                                'assets/icons/spinner.gif',
                                                width: 19.0,
                                                height: 19.0,
                                              )
                                            : Text(''),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
