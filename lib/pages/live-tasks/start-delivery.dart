import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:delivery_app/pages/live-tasks/order-delivered.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class StartDelivery extends StatefulWidget {
  final orderDetail;
  StartDelivery({Key key, this.orderDetail}) : super(key: key);
  static String tag = "startdelivery-page";
  @override
  _StartDeliveryState createState() => _StartDeliveryState();
}

class _StartDeliveryState extends State<StartDelivery> {
  bool val = true;
  GoogleMapController myController;
  MapType currentMapType = MapType.normal;
  final Set<Marker> markers = {};

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
            Container(
              height: screenHeight,
              width: screenWidth,
              child: GoogleMap(
                onMapCreated: (controller) {
                  setState(() {
                    myController = controller;
                  });
                  // markers.add(Marker(
                  //     // icon: BitmapDescriptor.fromAsset(
                  //     //   'assets/shop.png',
                  //     // ),
                  //     markerId: MarkerId(LatLng(
                  //             widget.deliveryBoyLatLong['latitude'],
                  //             widget.deliveryBoyLatLong['longitude'])
                  //         .toString()),
                  //     position: LatLng(widget.deliveryBoyLatLong['latitude'],
                  //         widget.deliveryBoyLatLong['longitude'])));
                  markers.add(Marker(
                      // icon: BitmapDescriptor.fromAsset(
                      //   'assets/shop.png',
                      // ),
                      markerId: MarkerId(LatLng(
                              widget.orderDetail['location']['latitude'],
                              widget.orderDetail['location']['longitude'])
                          .toString()),
                      position: LatLng(
                          widget.orderDetail['location']['latitude'],
                          widget.orderDetail['location']['longitude'])));
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
              bottom: screenHeight * 0.0001,
              child: new Container(
//                height: 50.0,
                alignment: Alignment.center,
                width: screenWidth,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF26707070)),
                  color: bgcolor,
                ),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
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
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                OrderDelivered(orderDetail: widget.orderDetail),
                          ),
                        );
                        //     Navigator.of(context).pushNamed(OrderDelivered.tag);
                      },
                      child: new Container(
                        height: 50.0,
                        padding: EdgeInsets.only(left: 5.0, right: 5.0),
                        alignment: Alignment.center,
                        color: red,
                        child: new Text(
                          'Start Delivery',
                          style: textwhites(),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: new Container(
          height: screenHeight * 0.17,
          padding: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Text(
                '${widget.orderDetail['shippingAddress'] == null ? "" : widget.orderDetail['shippingAddress']['name']}',
                style: textmediumb(),
              ),
              new Text(
                '${widget.orderDetail['shippingAddress'] == null ? "" : widget.orderDetail['shippingAddress']['locationName']}'
                ' ${widget.orderDetail['shippingAddress'] == null ? "" : widget.orderDetail['shippingAddress']['address']}',
                style: textblack(),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Text(
                    'Help',
                    textAlign: TextAlign.end,
                    style: textblueblack(),
                  ),
                  new Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: new Image.asset('assets/icons/headset.png'))
                ],
              )
            ],
          ),
        ));
  }
}
