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
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String id = prefs.getString('token');
  runApp(new MyApp(id: id));

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, //top bar color
    statusBarIconBrightness: Brightness.light, //top bar icons
  ));
}

class MyApp extends StatefulWidget {
  final id;

  MyApp({Key key, this.id}) : super(key: key);
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
  var id;

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
      home: routing(),
      routes: routes,
    );
  }

  routing() {
   
    if (widget.id != null) {
      return HomePage();
    } else {
      return Login();
    }
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('token');
    return id;
  }
}
