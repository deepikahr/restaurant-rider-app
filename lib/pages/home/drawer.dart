import 'dart:convert';

import 'package:delivery_app/pages/auth/login.dart';
import 'package:delivery_app/pages/home/home.dart';
import 'package:delivery_app/pages/main-tabs/earnings.dart';
import 'package:delivery_app/pages/main-tabs/order.dart';
import 'package:delivery_app/pages/profile/profile.dart';

import 'package:delivery_app/services/auth.dart';
import 'package:delivery_app/services/constant.dart';
import 'package:delivery_app/services/orders-service.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class drawer extends StatefulWidget {
  @override
  _drawerState createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  String name;
  String email;
  String profileImage;
  String gender, picture;
  var userData;
  @override
  void initState() {
    super.initState();
    userInformation();
  }

  void userInformation() async {
    await getUserInfo().then((response) {
      final int statusCode = response.statusCode;
      // print(json.decode(response.body));
      userData = json.decode(response.body);
      // print(userData['logo']);

      if (statusCode != 200 || json == null) {
        throw new Exception("Error while fetching data");
      } else {
        setState(() {
          name = userData['name'];
          picture = userData['logo'];
        });
      }
    });
  }

  Widget _buildMenuProfileLogo(String imgUrl) {
    return Padding(
      padding: EdgeInsets.only(top: 30.0, bottom: 10.0),
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: new BoxDecoration(
          border: new Border.all(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(80.0),
        ),
        child: imgUrl == null
            ? new CircleAvatar(
                backgroundImage: new AssetImage('assets/bgs/bg.png'))
            : new CircleAvatar(
                backgroundImage: new NetworkImage(imgUrl),
                radius: 80.0,
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: Center(
          child: new ListView(
            children: <Widget>[
              Stack(
                fit: StackFit.passthrough,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: new Column(
                      children: <Widget>[
                        new Padding(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: Column(
                              children: <Widget>[
                                new Image.asset(
                                  'assets/imgs/logo.png',
                                  // color: primary,
                                  width: 150.0,
                                  height: 100.0,
                                ),
                                Text(APP_NAME)
                              ],
                            )),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => Profile(),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 5.0, right: 5.0),
                            padding: EdgeInsets.only(left: 12.0, right: 12.0),
                            decoration: BoxDecoration(
                                border: Border(
                              top: BorderSide(width: 1.0),
                              bottom: BorderSide(width: 1.0),
                            )),
                            child: Row(
                              children: <Widget>[
                                _buildMenuProfileLogo(picture),
                                Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                ),
                                name != null
                                    ? Text(
                                        name.toUpperCase(),
                                        // style: hintStyleWhitePNR()
                                      )
                                    : Container(height: 0, width: 0),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(HomePage.tag);
                          },
                          child: new ListTile(
                            contentPadding: EdgeInsets.only(left: 36.0),
                            leading: Image.asset(
                              'assets/icons/home.png',
                              color: primary,
                            ),
                            title: new Text(
                              'Home',
//                              style: lightTextSmallHNB(),
                            ),
                            trailing: new Icon(
                              Icons.chevron_right,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(Earnings.tag);
                          },
                          child: new ListTile(
                            contentPadding: EdgeInsets.only(left: 36.0),
                            leading: new Icon(
                              Icons.attach_money,
                              color: primary,
                            ),
                            title: new Text(
                              'Earnings',
//                              style: lightTextSmallHNB(),
                            ),
                            trailing: new Icon(
                              Icons.chevron_right,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(Order.tag);
                          },
                          child: new ListTile(
                            contentPadding: EdgeInsets.only(left: 36.0),
                            leading: new Image.asset(
                              'assets/icons/order.png',
                              color: primary,
                            ),
                            title: new Text(
                              'Orders',
//                              style: lightTextSmallHNB(),
                            ),
                            trailing: new Icon(
                              Icons.chevron_right,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            pref.remove('token');
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed(Login.tag);
                          },
                          child: new ListTile(
                            contentPadding: EdgeInsets.only(left: 36.0),
                            leading: new Icon(
                              Icons.exit_to_app,
                              color: primary,
                            ),
                            title: new Text(
                              'Logout',
//                              style: lightTextSmallHNB(),
                            ),
                            trailing: new Icon(
                              Icons.chevron_right,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
