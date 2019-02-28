import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:delivery_app/pages/home/home.dart';
import '../../services/auth-service.dart';
import '../../services/common.dart';
import '../../blocks/validation.dart';

class Login extends StatefulWidget {
  static String tag = 'login-page';
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  String email, password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffKey = GlobalKey<ScaffoldState>();

  login() {
    print('herrr help me');
    print('$email    $password');
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      Map<String, dynamic> body = {'email': email, 'password': password};
      print('$email    $password');
      AuthService.login(body).then((onValue) {
        if (onValue['message'] != null) {
          // print(onValue['message']);
          showSnackbar('Somthing went Wronng');
        }

        if (onValue['token'] != null) {
          Common.setToken(onValue['token']).then((saved) {
            if (saved) {
              print(onValue['token']);
              showSnackbar('Login Successful');
              Future.delayed(Duration(milliseconds: 1500), () {
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
        print(onError);
      });
    } else {
      print('not valid');
    }
  }

  showSnackbar(message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 3000),
    );
    _scaffKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return new Scaffold(
        key: _scaffKey,
        backgroundColor: primary,
        body: new Stack(
          children: <Widget>[
            Positioned(
                top: screenHeight * 0.2,
                child: Container(
                  margin: EdgeInsets.only(left: 10.0),
                  width: screenWidth * 0.95,
                  color: Colors.white,
                  child: Form(
                    key: _formkey,
                    child: new Column(
                      children: <Widget>[
                        new Padding(
                          padding: EdgeInsets.only(top: 90.0),
                          child: new Text(
                            'Enter your Employee Id',
                            style: textmediumblacka(),
                          ),
                        ),
                        buildLoginTextField(),
                        new Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: new Text(
                            'Enter your Password',
                            style: textmediumblacka(),
                          ),
                        ),
                        buildPasswordTextField(),
                        buildLoginButton()
                      ],
                    ),
                  ),
                )),
            Positioned(
              left: screenWidth * 0.4,
              top: screenHeight * 0.14,
              child: new Container(
                width: 80.0,
                height: 80.0,
                padding: EdgeInsets.only(top: 28.0),
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: bglight,
//                   boxShadow: [
//                     new BoxShadow(
//                     color: Colors.black,
//                     blurRadius: 5.0,
//                   ),]
                ),
                child: new Text('Logo',
                    textAlign: TextAlign.center, style: textmediumblacka()),
              ),
            )
          ],
        ));
  }

  Widget buildLoginTextField() {
    return new Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 20.0),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF707070).withOpacity(0.32))),
      child: new TextFormField(
        keyboardType: TextInputType.emailAddress,
        validator: (String value) {
          if (value.isEmpty ||
              !RegExp(Validators.emailPattern).hasMatch(value)) {
            return 'Please enter valid email';
          }
        },
        onSaved: (String value) {
          email = value;
        },
        decoration: new InputDecoration(
          labelStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
        ),
        style: TextStyle(
          color: Colors.black54,
          fontSize: 16.0,
        ),
      ),
    );
  }

  Widget buildPasswordTextField() {
    return new Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 20.0),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF707070).withOpacity(0.32))),
      child: new TextFormField(
        keyboardType: TextInputType.text,
        validator: (String value) {
          if (value.isEmpty || value.length < 6) {
            return 'Please must constains 6 charector long';
          }
        },
        onSaved: (String value) {
          password = value;
        },
        decoration: new InputDecoration(
          labelStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
        ),
        style: TextStyle(
          color: Colors.black54,
          fontSize: 16.0,
        ),
        obscureText: true,
      ),
    );
  }

  Widget buildLoginButton() {
    return RawMaterialButton(
        onPressed: login,
        child: Container(
          color: redbtn,
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
          margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
          alignment: AlignmentDirectional.center,
          child: Text(
            "Sign In",
            textAlign: TextAlign.center,
            style: textwhitesmall(),
          ),
        ));
  }
}
