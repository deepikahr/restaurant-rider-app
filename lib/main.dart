import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:delivery_app/pages/home/home.dart';
import 'package:delivery_app/pages/main-tabs/live-task.dart';
import 'package:delivery_app/pages/main-tabs/earnings.dart';
import 'package:delivery_app/pages/main-tabs/order.dart';
import 'package:delivery_app/pages/live-tasks/location.dart';
import 'package:delivery_app/pages/live-tasks/order-placed.dart';
import 'package:delivery_app/pages/live-tasks/start-delivery.dart';
import 'package:delivery_app/pages/live-tasks/order-delivered.dart';
import 'package:delivery_app/pages/auth/login.dart';
import 'package:flutter_stetho/flutter_stetho.dart';

void main() async {
  Stetho.initialize();
  runApp(new MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//    systemNavigationBarColor: Colors.blue,
    statusBarColor: Colors.transparent,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final routes = <String, WidgetBuilder>{
    HomePage.tag: (context) => HomePage(),
    LiveTasks.tag: (context) => LiveTasks(),
    Earnings.tag: (context) => Earnings(),
    Order.tag: (context) => Order(),
    LocationDetail.tag: (context) => LocationDetail(),
    OrderPlaced.tag: (context) => OrderPlaced(),
    StartDelivery.tag: (context) => StartDelivery(),
    OrderDelivered.tag: (context) => OrderDelivered(),
    Login.tag: (context) => Login(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.white,
        cursorColor: Colors.black,
        unselectedWidgetColor: Colors.grey,
      ),
      home: Login(),
      routes: routes,
    );
  }
}
