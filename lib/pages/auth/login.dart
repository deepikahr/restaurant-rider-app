import 'package:delivery_app/services/localizations.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:delivery_app/pages/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/auth-service.dart';
import '../../services/common.dart';

class Login extends StatefulWidget {
  static String tag = 'login-page';
  final Map<String, Map<String, String>> localizedValues;
  final String locale;

  Login({Key key, this.locale, this.localizedValues}) : super(key: key);

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  String email, password;
  bool loading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      Map<String, dynamic> body = {
        'email': email,
        'password': password,
        "playerId": prefs.getString("playerId")
      };
      if (mounted) {
        setState(() {
          loading = true;
        });
      }
      AuthService.login(
        body,
      ).then((onValue) {
        if (mounted) {
          setState(() {
            loading = false;
          });
        }
        if (onValue['message'] != null) {
          showSnackbar(onValue['message']);
        }

        if (onValue['token'] != null) {
          showSnackbar(MyLocalizations.of(context).loginSuccessful);
          Common.setToken(onValue['token']).then((saved) {
            if (saved) {
              Future.delayed(Duration(milliseconds: 1500), () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => HomePage(
                        locale: widget.locale,
                        localizedValues: widget.localizedValues,
                      ),
                    ),
                    (Route<dynamic> route) => false);
              });
            }
          });
        }
      }).catchError((onError) {
        if (mounted) {
          setState(() {
            loading = false;
          });
        }
      });
    } else {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
      return;
    }
  }

  void showSnackbar(message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 3000),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
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
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(5.0)),
                            ),
                            alignment: FractionalOffset.center,
                            child: new TextFormField(
                              initialValue: "staff1@ionicfirebaseapp.com",
                              style: TextStyle(color: Colors.black),
                              decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  hintText:
                                      MyLocalizations.of(context).yourEmail,
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
                                  return MyLocalizations.of(context)
                                      .pleaseEnterValidEmail;
                                } else
                                  return null;
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
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(5.0)),
                            ),
                            alignment: FractionalOffset.center,
                            child: new TextFormField(
                              initialValue: "123456",
                              style: TextStyle(color: Colors.black),
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: MyLocalizations.of(context).password,
                                hintStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.0,
                                ),
                                icon: new Icon(Icons.lock, color: Colors.black),
                              ),
                              keyboardType: TextInputType.text,
                              validator: (String value) {
                                if (value.isEmpty || value.length < 6) {
                                  return MyLocalizations.of(context)
                                      .passwordShouldBeAtleast6CharLong;
                                } else
                                  return null;
                              },
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
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: RawMaterialButton(
                              onPressed: login,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    MyLocalizations.of(context)
                                        .loginToYourAccount,
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
      ),
    );
  }
}
