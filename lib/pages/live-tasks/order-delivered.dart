import 'dart:convert';
import 'package:delivery_app/pages/home/home.dart';
import 'package:delivery_app/pages/live-tasks/order-details.dart';
import 'package:delivery_app/pages/map/custom_map.dart';
import 'package:delivery_app/services/common.dart';
import 'package:delivery_app/services/localizations.dart';
import 'package:delivery_app/services/orders-service.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDelivered extends StatefulWidget {
  final orderDetail;
  final Map<String, Map<String, String>> localizedValues;
  final String locale, currency;

  OrderDelivered(
      {Key key,
      this.orderDetail,
      this.locale,
      this.localizedValues,
      this.currency})
      : super(key: key);
  static String tag = "orderdelivered-page";

  @override
  _OrderDeliveredState createState() => _OrderDeliveredState();
}

class _OrderDeliveredState extends State<OrderDelivered> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  orderDelivereds() {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    Map<String, dynamic> body = {"status": "Delivered"};
    var data = json.encode(body);
    OrdersService.orderDelivered(data, widget.orderDetail['_id'])
        .then((response) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomePage(
              locale: widget.locale,
              localizedValues: widget.localizedValues,
            ),
          ),
          (Route<dynamic> route) => false);
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((error) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
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
          title: new Text(
            MyLocalizations.of(context).liveTasks,
            style: textwhitesmall(),
          ),
        ),
        body: new Stack(
          children: <Widget>[
            new ListView(
              children: <Widget>[
                SingleChildScrollView(
                    child: new Padding(
                  padding: EdgeInsets.all(20.0),
                  child: new Column(
                    children: <Widget>[
                      new Text(
                        '${widget.orderDetail['shippingAddress'] == null ? "" : widget.orderDetail['shippingAddress']['address']}'
                        '${widget.orderDetail['shippingAddress'] == null ? "" : widget.orderDetail['shippingAddress']['postalCode']}',
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
                )),
              ],
            ),
            Positioned(
              top: 140,
              child: Container(
                height: 350,
                width: screenWidth,
                child: CustomMapForStoreToCustomer(
                  orderDetail: widget.orderDetail,
                ),
              ),
            ),
            new Positioned(
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
                    new Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            buildItem(MyLocalizations.of(context).orderID,
                                widget.orderDetail['orderID']),
                            buildItem(
                                MyLocalizations.of(context).createdAt,
                                widget.orderDetail['createdAtTime'] == null
                                    ? ""
                                    : DateFormat('dd-MMM-yy hh:mm a').format(
                                        new DateTime.fromMillisecondsSinceEpoch(
                                            widget.orderDetail[
                                                'createdAtTime']))),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            buildItem(MyLocalizations.of(context).totalBill,
                                '${widget.currency}${double.parse(widget.orderDetail['grandTotal'].toString()).toStringAsFixed(2)}'),
                            buildItem(MyLocalizations.of(context).paymentMode,
                                widget.orderDetail['paymentOption']),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderDetails(
                                            currency: widget.currency,
                                            localizedValues:
                                                widget.localizedValues,
                                            locale: widget.locale,
                                            orderDetail: widget.orderDetail,
                                          ))),
                              child: Text(
                                MyLocalizations.of(context).viewOrderDetails,
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 14,
                                    color: primary),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 145),
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: GFButton(
                            fullWidthButton: false,
                            onPressed: () {
                              _launchMap(LatLng(
                                widget.orderDetail['shippingAddress']
                                    ['location']['lat'],
                                widget.orderDetail['shippingAddress']
                                    ['location']['long'],
                              ));
                            },
                            text: MyLocalizations.of(context)
                                .toCustomer
                                .toUpperCase(),
                            textStyle: textDRed(),
                            icon: Icon(Icons.directions, color: red),
                            color: Colors.white,
                            size: 35,
                            borderShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: isLoading
            ? SizedBox(
                height: 50,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(primary),
                  ),
                ),
              )
            : RawMaterialButton(
                onPressed: orderDelivereds,
                child: Container(
                  color: redbtn,
                  height: 50.0,
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    MyLocalizations.of(context).orderDelivered,
                    textAlign: TextAlign.center,
                    style: textwhitesmall(),
                  ),
                ),
              ));
  }

  buildItem(title, value) {
    return Row(
      children: <Widget>[
        Text(
          title,
          style: textdblackMedium(),
        ),
        Text(' : '),
        Text(
          value.toString(),
          style: textboldblackMedium(),
        )
      ],
    );
  }

  void _launchMap(LatLng location) async {
    var mapSchema =
        'google.navigation:q=${location.latitude},${location.longitude}';
    if (await canLaunch(mapSchema)) {
      await launch(mapSchema);
    } else {
      _launchURL(
          'https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}');
    }
  }

  void _launchURL(url) async {
    await canLaunch(url)
        ? launch(url)
        : Common.showSnackbar(_scaffoldKey, '$url lauch failed');
  }
}
