import 'dart:convert';

import 'package:delivery_app/services/orders-service.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:delivery_app/pages/main-tabs/live-task.dart';
import 'package:delivery_app/pages/main-tabs/earnings.dart';
import 'package:delivery_app/pages/main-tabs/order.dart';
import 'package:delivery_app/pages/home/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [LiveTasks(), Earnings(), Order()];
  var userData;
  @override
  void initState() {
    // getCartItem();

    super.initState();
    fetchUserInfo();
  }

  fetchUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await OrdersService.getUserInfo().then((response) {
      // print(response);
      userData = json.decode(response.body);
      prefs.setString('userId', userData['_id']);
      prefs.setString('userName', userData['name']);
      prefs.setString('userEmail', userData['email']);
      prefs.setString('profileImage', userData['imageUrl']);
      prefs.setString('contactNumber', userData['contactNumber']);
      prefs.setString('address', userData['address']);
    });
  }

  @override
  Widget build(BuildContext context) {
    String title;
    if (_currentIndex == 0) {
      setState(() {
        title = 'Live Tasks';
      });
    } else if (_currentIndex == 1) {
      setState(() {
        title = 'Earnings';
      });
    } else {
      setState(() {
        title = 'Orders';
      });
    }
    return new Scaffold(
      drawer: drawer(),
      appBar: AppBar(
        backgroundColor: primary,
        iconTheme: IconThemeData(color: Colors.white),
//        title: new Text('Earning', style: textwhitesmall()),
        title: Text(title, style: textwhitesmall()),
      ),
      backgroundColor: Colors.white,
      body: _children[_currentIndex], // new
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          new BoxShadow(
            color: Color(0xFF1c000000),
            blurRadius: 6.0,
          ),
        ]),
        height: 70,
        child: Row(
          children: [
            Expanded(
              child: new InkWell(
                onTap: () {
                  onTabTapped(0);
                }, // new
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: 100.0,
                  color: _currentIndex == 0 ? primary : Colors.white12,
                  child: new Column(
                    children: <Widget>[
                      new Image.asset(
                        'assets/icons/home.png',
                        color: _currentIndex == 0 ? Colors.white : blackb,
                      ),
                      Text(
                        'Home',
                        style: TextStyle(
                          color: _currentIndex == 0 ? Colors.white : blackb,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  onTabTapped(1);
                }, // new
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: 100.0,
                  color: _currentIndex == 1 ? primary : Colors.white12,
                  child: new Column(
                    children: <Widget>[
                      new Icon(
                        Icons.attach_money,
                        color: _currentIndex == 1 ? Colors.white : blackb,
                      ),
                      Text(
                        'Earnings',
                        style: TextStyle(
                          color: _currentIndex == 1 ? Colors.white : blackb,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  onTabTapped(2);
                }, // new
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: 100.0,
                  color: _currentIndex == 2 ? primary : Colors.white12,
                  child: new Column(
                    children: <Widget>[
                      new Image.asset(
                        'assets/icons/order.png',
                        color: _currentIndex == 2 ? Colors.white : blackb,
                      ),
                      Text(
                        'Order',
                        style: TextStyle(
                          color: _currentIndex == 2 ? Colors.white : blackb,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
