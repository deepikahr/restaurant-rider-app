import 'dart:async';

import 'package:delivery_app/services/localizations.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/orders-service.dart';
import 'package:async_loader/async_loader.dart';
import 'package:location/location.dart';
import 'package:intl/intl.dart';
import 'package:delivery_app/pages/live-tasks/location.dart';

class LiveTasks extends StatefulWidget {
  static String tag = "livetasks-page";
  final Map<String, Map<String, String>> localizedValues;
  final String locale;

  LiveTasks({Key key, this.locale, this.localizedValues}) : super(key: key);
  @override
  _LiveTasksState createState() => _LiveTasksState();
}

class _LiveTasksState extends State<LiveTasks> {
  int orderIndex = 0;

  var startLocation,
      locationSubscription,
      formatter = new DateFormat('yyyy-MM-dd');

  String error;
  Location _location = Location();
  dynamic orderList;
  LocationData currentLocation;
  var addressData, currentLocationLatLong;

  bool isGetOrderLoading = false;
  String currency;
  @override
  void initState() {
    initPlatformState();
    getNewOrderToDeliveryBoy();
    new Timer.periodic(Duration(seconds: 60), (_) {
      if (mounted) {
        setState(() {
          isGetOrderLoading = false;
          getNewOrderToDeliveryBoy();
        });
      }
    });

    super.initState();
  }

  initPlatformState() async {
    currentLocation = await _location.getLocation();
  }

  getNewOrderToDeliveryBoy() async {
    if (mounted) {
      setState(() {
        isGetOrderLoading = true;
      });
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currency = prefs.getString('currency');
    String orderStatus = 'Accepted';
    await OrdersService.getAssignedOrdersListToDeliveryBoy(orderStatus)
        .then((value) {
          print(value.toString());
      if (mounted) {
        setState(() {
          orderList = value['response_data']['data'];
          isGetOrderLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: isGetOrderLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: primary,
                ),
              )
            : orderList.length > 0
                ? ListView(
                    children: <Widget>[
                      ListView.builder(
                        itemCount: orderList.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              if (mounted) {
                                setState(() {
                                  orderIndex = index;
                                });
                              }
                            },
                            child: Column(
                              children: <Widget>[
                                new Container(
                                  margin: EdgeInsets.only(top: 20.0),
                                  padding:
                                      EdgeInsets.only(left: 20.0, right: 20.0),
                                  color: yellow,
                                  height: 38.0,
                                  child: new Row(
                                    children: <Widget>[
                                      new Text(
                                        MyLocalizations.of(context).orderID +
                                            ' #${orderList[index]['orderID']}',
                                        style: textmediumsmall(),
                                      ),
                                      Expanded(
                                          child: new Text(
                                        orderList[index]['createdAtTime'] ==
                                                null
                                            ? ""
                                            : DateFormat('dd-MMM-yy hh:mm a')
                                                .format(new DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                    orderList[index]
                                                        ['createdAtTime'])),
                                        textAlign: TextAlign.end,
                                        style: textboldsmall(),
                                      ))
                                    ],
                                  ),
                                ),
                                new Container(
                                  color: Colors.white,
                                  child: new ListTile(
                                    leading: new Image.network(
                                      orderList[index]['productDetails'][0]
                                                  ['imageUrl'] ==
                                              null
                                          ? MyLocalizations.of(context).noImage
                                          : orderList[index]['productDetails']
                                              [0]['imageUrl'],
                                      height: 45.0,
                                    ),
                                    title: new Text(
                                      orderList[index]['productDetails'][0]
                                          ['restaurant'],
                                      style: textmediumb(),
                                    ),
                                    subtitle: new Text(
                                      orderList[index]['locationName'],
                                      style: textdblack(),
                                    ),
                                    trailing: new Image.asset(
                                        'assets/icons/right-arrow.png'),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      buildDeliveryOption(orderList[orderIndex])
                    ],
                  )
                : Padding(
                    padding: EdgeInsets.only(top: 100.0),
                    child: Center(
                      child: Text(
                        MyLocalizations.of(context).noOrders,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
      ),
    );
  }

  Widget pickupBuild(dynamic orders) {
    return Column(
      children: <Widget>[
        ListView.builder(
          itemCount: orders.length,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                if (mounted) {
                  setState(() {
                    orderIndex = index;
                  });
                }
              },
              child: Column(
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.only(top: 20.0),
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    color: yellow,
                    height: 38.0,
                    child: new Row(
                      children: <Widget>[
                        new Text(
                          MyLocalizations.of(context).orderID +
                              ' #${orders[index]['orderID']}',
                          style: textmediumsmall(),
                        ),
                        Expanded(
                          child: new Text(
                            orders[index]['createdAtTime'] == null
                                ? ""
                                : DateFormat('dd-MMM-yy hh:mm a').format(
                                    new DateTime.fromMillisecondsSinceEpoch(
                                        orders[index]['createdAtTime'])),
                            textAlign: TextAlign.end,
                            style: textboldsmall(),
                          ),
                        )
                      ],
                    ),
                  ),
                  new Container(
                    color: Colors.white,
                    child: new ListTile(
                      leading: new Image.network(
                        orders[index]['productDetails'][0]['imageUrl'] == null
                            ? MyLocalizations.of(context).noImage
                            : orders[index]['productDetails'][0]['imageUrl'],
                        height: 45.0,
                      ),
                      title: new Text(
                        orders[index]['productDetails'][0]['restaurant'],
                        style: textmediumb(),
                      ),
                      subtitle: new Text(
                        orders[index]['locationName'],
                        style: textdblack(),
                      ),
                      trailing: new Image.asset('assets/icons/right-arrow.png'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        buildDeliveryOption(orderList[orderIndex])
      ],
    );
  }

  Widget buildDeliveryOption(order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          margin: EdgeInsets.only(top: 5.0),
          padding: EdgeInsets.only(left: 0.0, right: 20.0),
          color: bgcolor,
          height: 38.0,
          child: new Row(
            children: <Widget>[
              Expanded(
                  child: new Stack(
                children: <Widget>[
                  new Image.asset(
                    'assets/imgs/greenbg.png',
                    color: primary,
                  ),
                  new Positioned(
                      height: MediaQuery.of(context).size.height * 0.7,
                      top: 10.0,
                      left: 10.0,
                      child: new Text(
                        MyLocalizations.of(context).orderID +
                            ' # ${order['orderID']}',
                        style: textmediumwhite(),
                      ))
                ],
              )),
            ],
          ),
        ),
        new Container(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            color: Colors.white,
            child: new InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (BuildContext context) => new LocationDetail(
                        orderDetail: order,
                        deliveryBoyLatLong: currentLocation,
                        locale: widget.locale,
                        localizedValues: widget.localizedValues,
                        currency: currency),
                  ),
                );
              },
              child: new Column(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: new Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: new Image.asset('assets/icons/red-pin.png'),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Padding(
                              padding: EdgeInsets.only(left: 4.0),
                              child: new Text(
                                '${order['shippingAddress'] == null ? "" : order['shippingAddress']['addressType']}',
                                style: textmediumb(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                          flex: 3,
                          fit: FlexFit.tight,
                          child: new Padding(
                            padding: EdgeInsets.only(right: 15.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Image.asset('assets/icons/right-arrow.png')
                              ],
                            ),
                          ))
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      Expanded(
                        child: new Padding(
                          padding: EdgeInsets.only(left: 55.0, right: 30.0),
                          child: new Text(
                            '${order['shippingAddress'] == null ? "" : order['shippingAddress']['flatNo']},${order['shippingAddress'] == null ? "" : order['shippingAddress']['address']},' +
                                '${order['shippingAddress'] == null ? "" : order['shippingAddress']['contactNumber']}',
                            style: textblack(),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )),
      ],
    );
  }
}
