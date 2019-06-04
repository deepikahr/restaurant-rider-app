import 'dart:async';
import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
// import 'package:delivery_app/pages/home/drawer.dart';
import '../../services/orders-service.dart';
import 'package:async_loader/async_loader.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:delivery_app/pages/live-tasks/location.dart';

class LiveTasks extends StatefulWidget {
  static String tag = "livetasks-page";
  @override
  _LiveTasksState createState() => _LiveTasksState();
}

class _LiveTasksState extends State<LiveTasks> {
  bool val = true;

  Map<String, double> startLocation;
  Map<String, double> currentLocation;

  StreamSubscription<Map<String, double>> locationSubscription;

  Location _location = new Location();
  bool permission = false;
  String error;

  bool currentWidget = true;

  Image image1;

  @override
  void initState() {
    super.initState();

    initPlatformState();
    getResult();
  }

  getResult() async {
    locationSubscription = await _location
        .onLocationChanged()
        .listen((Map<String, double> result) {
      if (mounted) {
        setState(() {
          currentLocation = result;
        });
      }
      print('kkkkkk $currentLocation');
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    Map<String, double> location;
    // Platform messages may fail, so we use a try/catch PlatformException.

    try {
      permission = await _location.hasPermission();
      location = await _location.getLocation();

      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
            'Permission denied - please ask the user to enable it from the app settings';
      }

      location = null;
    }

    if (mounted) {
      setState(() {
        startLocation = location;
      });
    }
  }

  var formatter = new DateFormat('yyyy-MM-dd');
  dynamic orderList;
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      GlobalKey<AsyncLoaderState>();

  getNewOrderToDeliveryBoy() async {
    String orderStatus = 'Accepted';
    return await OrdersService.getAssignedOrdersListToDeliveryBoy(orderStatus);
  }

  int orderIndex = 0;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    AsyncLoader asyncloader = AsyncLoader(
      key: _asyncLoaderState,
      initState: () async => await getNewOrderToDeliveryBoy(),
      renderLoad: () => Center(child: CircularProgressIndicator()),
      // renderError: ([error]) => NoData(
      //     message: 'Please check your internet connection!',
      //     icon: Icons.block),
      renderSuccess: ({data}) {
        if (data.length > 0) {
          orderList = data;
          print('ksdgfksdgfsdf--$orderList');

          return pickupBuild(data);
        } else {
          print('no data found');
          return pickupBuild(data);
        }
      },
    );

    return ListView(
      children: <Widget>[
        new SingleChildScrollView(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              asyncloader,
            ],
          ),
        )
      ],
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
                setState(() {
                  orderIndex = index;
                });
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
                          'Order #${orders[index]['orderID']}',
                          style: textmediumsmall(),
                        ),
                        Expanded(
                            child: new Text(
                          orders[index]['createdAt']
                              .toString()
                              .substring(0, 10),
                          textAlign: TextAlign.end,
                          style: textboldsmall(),
                        ))
                      ],
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.only(bottom: 25.0),
                    color: Colors.white,
                    child: new ListTile(
                      leading: new Image.network(
                        orders[index]['productDetails'][0]['imageUrl'],
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
                  new Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        new Text(
                          'CURRENT TASK',
                          textAlign: TextAlign.end,
                          style: textboldSmall(),
                        ),
                      ],
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
                  new Image.asset('assets/imgs/greenbg.png'),
                  new Positioned(
                      height: MediaQuery.of(context).size.height * 0.7,
                      top: 10.0,
                      left: 10.0,
                      child: new Text(
                        'Order # ${order['orderID']}',
                        style: textmediumwhite(),
                      ))
                ],
              )),
              // Expanded(
              //     child: new Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: <Widget>[
              //     new Image.asset('assets/icons/watch.png'),
              //     new Text(
              //       '29 Min',
              //       textAlign: TextAlign.end,
              //       style: textboldblack(),
              //     )
              //   ],
              // ))
            ],
          ),
        ),
        new Container(
            margin: EdgeInsets.only(bottom: 25.0),
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            color: Colors.white,
            child: new GestureDetector(
              onTap: () {
                // Navigator.of(context).pushNamed(Location.tag);
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new LocationDetail(
                            orderDetail: order,
                            deliveryBoyLatLong: currentLocation)));
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
                          )),
                      Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Padding(
                              padding: EdgeInsets.only(left: 4.0),
                              child: new Text(
                                '${order['shippingAddress']['name']}',
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
                              '${order['shippingAddress']['locationName']},${order['shippingAddress']['address']},Contact No- ${order['shippingAddress']['contactNumber']}',
                              style: textblack(),
                            )),
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
