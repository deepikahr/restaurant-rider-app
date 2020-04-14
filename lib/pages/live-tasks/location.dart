import 'package:delivery_app/services/localizations.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:delivery_app/pages/live-tasks/order-placed.dart';

class LocationDetail extends StatefulWidget {
  static String tag = "location-page";
  final orderDetail;
  final deliveryBoyLatLong;
  final Map<String, Map<String, String>> localizedValues;
  final String locale;

  LocationDetail(
      {Key key,
      this.orderDetail,
      this.deliveryBoyLatLong,
      this.locale,
      this.localizedValues})
      : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<LocationDetail> {
  GoogleMapController myController;
  MapType currentMapType = MapType.normal;
  final Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
            child: GoogleMap(
              onMapCreated: (controller) {
                if (mounted) {
                  setState(() {
                    myController = controller;
                  });
                }

                markers.add(
                  Marker(
                    markerId: MarkerId(LatLng(
                            widget.orderDetail['location']['latitude'],
                            widget.orderDetail['location']['longitude'])
                        .toString()),
                    position: LatLng(widget.orderDetail['location']['latitude'],
                        widget.orderDetail['location']['longitude']),
                  ),
                );
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  widget.orderDetail['location']['latitude'],
                  widget.orderDetail['location']['longitude'],
                ),
                zoom: 11.0,
              ),
              mapType: currentMapType,
              markers: markers,
            ),
          ),
          new Positioned(
              child: new Container(
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
                            widget.orderDetail['restaurantName'],
                            style: textmediumb(),
                          ),
                          Padding(
                              padding: EdgeInsetsDirectional.only(top: 5.0)),
                          new Text(
                            widget.orderDetail['locationName'],
                            style: textblack(),
                          )
                        ],
                      )),
                    ],
                  ))),
        ],
      ),
      bottomNavigationBar: RawMaterialButton(
        onPressed: () {
          showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                content: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          MyLocalizations.of(context).confirmation,
                          style: textmediumb(),
                        ),
                        new Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: new Text(
                            MyLocalizations.of(context)
                                .areyousureyouArrivedatRestaurant,
                            style: textblackc(),
                          ),
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FlatButton(
                              child: Text(
                                MyLocalizations.of(context).cancel,
                                style: textmediumblue(),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(context);
                              },
                            ),
                            FlatButton(
                              child: Text(
                                MyLocalizations.of(context).cONFIRM,
                                style: textmediumblue(),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new OrderPlaced(
                                      orderDetail: widget.orderDetail,
                                      locale: widget.locale,
                                      localizedValues: widget.localizedValues,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: Container(
          color: redbtn,
          height: 50.0,
          alignment: AlignmentDirectional.center,
          child: Text(
            MyLocalizations.of(context).arrivedatRestaurant,
            textAlign: TextAlign.center,
            style: textwhitesmall(),
          ),
        ),
      ),
    );
  }
}
