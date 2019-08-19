import 'dart:convert';

import 'package:delivery_app/pages/home/home.dart';
import 'package:delivery_app/services/orders-service.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:delivery_app/pages/live-tasks/start-delivery.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDelivered extends StatefulWidget {
  final orderDetail;
  OrderDelivered({Key key, this.orderDetail}) : super(key: key);
  static String tag = "orderdelivered-page";
  @override
  _OrderDeliveredState createState() => _OrderDeliveredState();
}

class _OrderDeliveredState extends State<OrderDelivered> {
  bool val = true;
  orderDelivereds() {
    Map<String, dynamic> body = {"status": "Delivered"};
    var data = json.encode(body);
    OrdersService.orderDelivered(data, widget.orderDetail['_id'])
        .then((response) {
      print(response);
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => new HomePage()));
      // verifyMsg = data['message'];
      // if (statusCode != 200) {
      //   otpError = true;
      // } else {
      //   prefs.setString('token', otpToken);
      //   otpVer = true;
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        iconTheme: IconThemeData(color: Colors.white),
        title: new Text('Live Tasks', style: textwhitesmall()),
      ),
      body: new Stack(
        children: <Widget>[
          new ListView(
            children: <Widget>[
              new SingleChildScrollView(
                  child: new Padding(
                padding: EdgeInsets.all(20.0),
                child: new Column(
                  children: <Widget>[
                    new Text(
                      '${widget.orderDetail['shippingAddress'] == null ? "" : widget.orderDetail['shippingAddress']['address']}'
                      '${widget.orderDetail['shippingAddress'] == null ? "" : widget.orderDetail['shippingAddress']['zip']}',
                      style: textlightblackh(),
                    ),
                    Padding(padding: EdgeInsets.only(top: 5.0)),
                    new Row(
                      children: <Widget>[
                        new Padding(padding: EdgeInsets.only(left: 5.0)),
                        Expanded(
                          child: new ListTile(
                            onTap: () async {
                              String phone = widget.orderDetail['userInfo']
                                      ['contactNumber']
                                  .toString();
                              if (await canLaunch("tel://$phone")) {
                                await launch("tel://$phone");
                              } else {
                                throw 'Could not launch $phone';
                              }
                            },
                            leading: new Icon(Icons.phone),
                            title: new Text(
                              "${widget.orderDetail['userInfo']['contactNumber']}",
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ))
            ],
          ),
          new Positioned(
//              top:screenHeight * 0.72,
              bottom: screenHeight * 0.0001,
              child: new Container(
                  padding: EdgeInsets.only(
                      top: 10.0, bottom: 20.0, right: 20.0, left: 20.0),
                  color: bgcolor,
                  width: screenWidth,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          Expanded(
                              child: new Text(
                            'Order id : ${widget.orderDetail['orderID']}',
                            style: textdblack(),
                          )),
                          Expanded(
                              child: new Text(
                            new DateFormat.yMMMMd("en_US").add_jm().format(
                                DateTime.parse(
                                    '${widget.orderDetail['createdAt']}')),
                            textAlign: TextAlign.end,
                            style: textdblack(),
                          ))
                        ],
                      ),
                      new Padding(padding: EdgeInsets.only(top: 5.0)),
                      new Text(
                        'Total Bill : \$ ${widget.orderDetail['grandTotal']}',
                        style: textboldblack(),
                      ),
                      new Padding(padding: EdgeInsets.only(top: 5.0)),
                      new Row(
                        children: <Widget>[
                          new Text(
                            'Collect from Customer :' +
                                        widget.orderDetail['paymentOption'] ==
                                    'COD'
                                ? 'Collect from Customer :\$ ${widget.orderDetail['grandTotal']}'
                                : ' ',
                            style: textboldblack(),
                          ),
                          Expanded(
                              child: new Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              new Text(
                                'Help',
                                textAlign: TextAlign.end,
                                style: textblueblack(),
                              ),
                              new Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child:
                                    new Image.asset('assets/icons/headset.png'),
                              )
                            ],
                          ))
                        ],
                      ),
                    ],
                  )))
        ],
      ),
      bottomNavigationBar: RawMaterialButton(
          onPressed: orderDelivereds,
          child: Container(
            color: redbtn,
            height: 50.0,
            alignment: AlignmentDirectional.center,
            child: Text(
              "Order Delivered",
              textAlign: TextAlign.center,
              style: textwhitesmall(),
            ),
          )),
    );
  }
}
