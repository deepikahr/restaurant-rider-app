import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:delivery_app/pages/tabs/tabs-heading.dart';
import 'package:delivery_app/pages/home/drawer.dart';

class Order extends StatefulWidget {
  static String tag = "order-page";
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  bool val = true;
  @override
  Widget build(BuildContext context) {
    print('inside oder data');
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ListView(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          new TabsHeading(),
        ],
      ),
    );
  }

//  void something(bool e) {
//    setState(() {
//      if (e){
//        message = 'yes';
//        val=true;
//        e = true;
//      } else{
//        message = 'No';
//        val = false;
//      }
//    });
//  }
}
