import 'dart:convert';

import 'package:delivery_app/pages/auth/login.dart';
import 'package:delivery_app/pages/home/home.dart';
import 'package:delivery_app/pages/main-tabs/earnings.dart';
import 'package:delivery_app/pages/settings/settings.dart';
import 'package:delivery_app/services/auth.dart';
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
  String gender;
  var userData;
  @override
  void initState() {
    super.initState();
    userInformation();
  }

  void userInformation() async {
    // await getUserInfo().then((response) {
    //   final int statusCode = response.statusCode;
    //    print(json.decode(response.body));
    //   userData = json.decode(response.body);
    //   if (statusCode != 200 || json == null) {
    //     throw new Exception("Error while fetching data");
    //   }
    // });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      email = prefs.getString('email');

      print('$name');
      print('$email');
    });
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
                          padding: EdgeInsets.only(top: 30.0, bottom: 40.0),
                          child: new Image.asset(
                            'assets/icons/home.png',
                            color: primary,
                            width: 150.0,
                            height: 30.0,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => Settings(),
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
                            child: ListTile(
                              leading: profileImage != null
                                  ? new CircleAvatar(
                                      backgroundImage:
                                          new NetworkImage("$profileImage"),
                                    )
                                  : new CircleAvatar(
                                      backgroundImage:
                                          new AssetImage("assets/imgs/dp.png")),
                              title: Text(
                                "$name",
                              ),
                              subtitle: Text("Edit Profile"),
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
                            Navigator.of(context).pushNamed(Earnings.tag);
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
