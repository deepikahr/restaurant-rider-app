import 'package:flutter/material.dart';
import 'package:delivery_app/pages/tabs/tabs-heading.dart';

class Order extends StatefulWidget {
  static String tag = "order-page";
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  bool val = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ListView(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          new TabsHeading(),
        ],
      ),
    ));
  }
}
