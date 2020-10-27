import 'dart:convert';
import 'package:delivery_app/pages/live-tasks/order-delivered.dart';
import 'package:delivery_app/pages/map/custom_map.dart';
import 'package:delivery_app/services/common.dart';
import 'package:delivery_app/services/localizations.dart';
import 'package:delivery_app/services/orders-service.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationDetail extends StatefulWidget {
  static String tag = "location-page";
  final orderDetail;
  final deliveryBoyLatLong;
  final Map<String, Map<String, String>> localizedValues;
  final String locale, currency;

  LocationDetail(
      {Key key,
      this.orderDetail,
      this.deliveryBoyLatLong,
      this.locale,
      this.localizedValues,
      this.currency})
      : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<LocationDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: bglight,
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
          Container(
            height: screenHeight,
            width: screenWidth,
            child: CustomMapForAgentToStore(
              orderDetail: widget.orderDetail,
            ),
          ),
          Positioned(
              child: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(20.0),
                  color: Colors.white,
                  height: 100.0,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            widget.orderDetail['productDetails'][0]
                                    ['restaurant'] ??
                                "",
                            style: textmediumb(),
                          ),
                          Padding(
                              padding: EdgeInsetsDirectional.only(top: 5.0)),
                          new Text(
                            widget.orderDetail['locationName'],
                            style: textmediumb(),
                          )
                        ],
                      )),
                      Text(
                        '${MyLocalizations.of(context).grandTotal}  : ${widget.currency}${double.parse(widget.orderDetail['grandTotal'].toString()).toStringAsFixed(2)}',
                        style: textmediumb(),
                      ),
                    ],
                  )),
              Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: GFButton(
                      fullWidthButton: false,
                      onPressed: () {
                        _launchMap(LatLng(
                            widget.orderDetail['location']['latitude'],
                            widget.orderDetail['location']['longitude']));
                      },
                      text: MyLocalizations.of(context).toStore.toUpperCase(),
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
            ],
          )),
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
              onPressed: () {
                if (mounted) {
                  setState(() {
                    isLoading = true;
                  });
                }
                Map<String, dynamic> body = {"status": "On the Way"};
                var data = json.encode(body);
                OrdersService.orderDelivered(data, widget.orderDetail['_id'])
                    .then((value) {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => new OrderDelivered(
                          orderDetail: widget.orderDetail,
                          locale: widget.locale,
                          localizedValues: widget.localizedValues,
                          currency: widget.currency),
                    ),
                  );
                }).catchError((error) {
                  if (mounted) {
                    setState(() {
                      isLoading = false;
                    });
                  }
//                  showSnackbar(error.toString());
                });
              },
              child: Container(
                color: redbtn,
                height: 50.0,
                alignment: AlignmentDirectional.center,
                child: Text(
                  MyLocalizations.of(context).orderPicked,
                  textAlign: TextAlign.center,
                  style: textwhitesmall(),
                ),
              ),
            ),
    );
  }

  void showSnackbar(message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 3000),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
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
