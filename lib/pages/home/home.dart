import 'dart:convert';

import 'package:delivery_app/pages/home/drawer.dart';
import 'package:delivery_app/pages/main-tabs/earnings.dart';
import 'package:delivery_app/pages/main-tabs/live-task.dart';
import 'package:delivery_app/pages/main-tabs/order.dart';
import 'package:delivery_app/services/auth-service.dart';
import 'package:delivery_app/services/background-location-service.dart';
import 'package:delivery_app/services/localizations.dart' show MyLocalizations;
import 'package:delivery_app/services/orders-service.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';
  final Map<String, Map<String, String>> localizedValues;
  final String locale;
  final int currentIndex;
  final bool isAfterLogin;

  HomePage(
      {Key key,
      this.locale,
      this.localizedValues,
      this.currentIndex,
      this.isAfterLogin = false})
      : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String userId;
  final List<Widget> _children = [LiveTasks(), Earnings(), Order()];
  var userData;
  BackgroundLocationService _backgroundLocationService =
      BackgroundLocationService();

  @override
  void initState() {
    getGlobalSettingsData();
    if (widget.currentIndex != null) {
      if (mounted) {
        setState(() {
          _currentIndex = widget.currentIndex;
        });
      }
    }
    _backgroundLocationService.initialize(isAfterLogin: true);
    super.initState();
  }

  @override
  void dispose() {
    print(userId);
    _backgroundLocationService.disconnectSocket(userId);
    super.dispose();
  }

  getGlobalSettingsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await AuthService.getAdminSettings().then((onValue) {
      var adminSettings = onValue;
      fetchUserInfo();
      if (adminSettings['currency'] == null) {
        prefs.setString('currency', '\$');
      } else {
        prefs.setString(
            'currency', '${adminSettings['currency']['currencySymbol']}');
      }
    });
  }

  fetchUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await OrdersService.getUserInfo().then((response) {
      userId = response['_id'];
      userData = json.decode(response);
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
      if (mounted) {
        setState(() {
          title = MyLocalizations.of(context).liveTasks;
        });
      }
    } else if (_currentIndex == 1) {
      if (mounted) {
        setState(() {
          title = MyLocalizations.of(context).earnings;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          title = MyLocalizations.of(context).orders;
        });
      }
    }
    return new Scaffold(
      drawer: DrawerPage(
        locale: widget.locale,
        localizedValues: widget.localizedValues,
      ),
      appBar: AppBar(
        backgroundColor: primary,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(title, style: textwhitesmall()),
      ),
      backgroundColor: Colors.white,
      body: _children[_currentIndex],
      // new
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
                        MyLocalizations.of(context).home,
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
                        MyLocalizations.of(context).earnings,
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
                        MyLocalizations.of(context).orders,
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
