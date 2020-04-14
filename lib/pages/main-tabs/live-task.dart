import 'package:delivery_app/services/localizations.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import '../../services/orders-service.dart';
import 'package:async_loader/async_loader.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
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
      currentLocation,
      locationSubscription,
      _location = new Location(),
      formatter = new DateFormat('yyyy-MM-dd');

  String error;
  PermissionStatus permissionGranted;

  dynamic orderList;
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      GlobalKey<AsyncLoaderState>();
  @override
  void initState() {
    super.initState();

    initPlatformState();
    getResult();
  }

  getResult() async {
    _location.onLocationChanged.listen((LocationData result) {
      if (mounted) {
        setState(() {
          currentLocation = result;
        });
      }
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    var location;
    // Platform messages may fail, so we use a try/catch PlatformException.

    try {
      permissionGranted = await _location.hasPermission();
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

  getNewOrderToDeliveryBoy() async {
    String orderStatus = 'Accepted';
    await OrdersService.getAssignedOrdersListToDeliveryBoy(orderStatus)
        .then((onValue) {});
  }

  @override
  Widget build(BuildContext context) {
    AsyncLoader asyncloader = AsyncLoader(
      key: _asyncLoaderState,
      initState: () async => await getNewOrderToDeliveryBoy(),
      renderLoad: () => Center(
          child: CircularProgressIndicator(
        backgroundColor: primary,
      )),
      renderError: ([error]) => new Text(
          MyLocalizations.of(context).somethingwentwrongpleaserestarttheapp),
      renderSuccess: ({data}) {
        if (data != null && data.length > 0) {
          orderList = data;

          return pickupBuild(data);
        } else {
          return Padding(
            padding: EdgeInsets.only(top: 100.0),
            child: Center(
              child: Text(
                MyLocalizations.of(context).noOrders,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          );
        }
      },
    );

    return Scaffold(
      body: new Center(
        child: asyncloader,
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
                          orderList[index]['createdAtTime'] != null
                              ? new DateFormat.yMMMMd("en_US").format(
                                  new DateTime.fromMillisecondsSinceEpoch(
                                      orderList[index]['createdAtTime']))
                              : new DateFormat.yMMMMd("en_US").format(
                                  DateTime.parse(
                                      '${orderList[index]['createdAt']}')),
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
                  new Image.asset('assets/imgs/greenbg.png'),
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
            child: new GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (BuildContext context) => new LocationDetail(
                      orderDetail: order,
                      deliveryBoyLatLong: currentLocation,
                      locale: widget.locale,
                      localizedValues: widget.localizedValues,
                    ),
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
                                '${order['shippingAddress'] == null ? "" : order['shippingAddress']['name']}',
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
                            '${order['shippingAddress'] == null ? "" : order['shippingAddress']['locationName']},${order['shippingAddress'] == null ? "" : order['shippingAddress']['address']},' +
                                MyLocalizations.of(context).contactNo +
                                ' -${order['shippingAddress'] == null ? "" : order['shippingAddress']['contactNumber']}',
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
