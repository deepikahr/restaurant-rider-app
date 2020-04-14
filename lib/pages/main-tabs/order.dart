import 'package:flutter/material.dart';
import 'package:delivery_app/pages/tabs/tabs-heading.dart';

class Order extends StatefulWidget {
  static String tag = "order-page";
  final Map<String, Map<String, String>> localizedValues;
  final String locale;

  Order({Key key, this.locale, this.localizedValues}) : super(key: key);
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ListView(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            new TabsHeading(
              locale: widget.locale,
              localizedValues: widget.localizedValues,
            ),
          ],
        ),
      ),
    );
  }
}
