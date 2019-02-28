import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:delivery_app/pages/live-tasks/order-placed.dart';

class Location extends StatefulWidget {
  static String tag = "location-page";
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  bool val = true;
  GoogleMapController myController;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bglight,
      appBar: AppBar(
        backgroundColor: primary,
        iconTheme: IconThemeData(color: Colors.white),
        title: new Text('Live Tasks', style: textwhitesmall()),
        actions: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                'Online',
                textAlign: TextAlign.end,
                style: textwhite(),
              ),
              new Switch(
                  value: val,
                  activeColor: red,
                  activeTrackColor: darkgreen,
                  onChanged: (bool e) => true),
            ],
          )
        ],
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
                },
                compassEnabled: true,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  bearing: 360.0,
                  target: LatLng(
                    12.9170646,
                    77.5898977,
                  ),
                  tilt: 10.0,
                  zoom: 10.0,
                ),
              )),
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
                            'Global Restaurant',
                            style: textmediumb(),
                          ),
                          Padding(
                              padding: EdgeInsetsDirectional.only(top: 5.0)),
                          new Text(
                            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,',
                            style: textblack(),
                          )
                        ],
                      )),

                      Expanded(
                          child: new Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new Column(
                            children: <Widget>[
                              new Text(
                                'Navigate',
                                style: textsmallregular(),
                                textAlign: TextAlign.end,
                              ),
                              Padding(
                                  padding:
                                      EdgeInsetsDirectional.only(top: 5.0)),
                              new Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: new Image.asset(
                                  'assets/icons/navigate.png',
                                ),
                              )
                            ],
                          )
                        ],
                      ))
//                Expanded(
//                    child: FlatButton(onPressed:
//                myController == null ? null : (){
////                  myController.addMarker(
////                      MarkerOptions(
////                        draggable: false,
////                        position: LatLng( 12.9716, 77.5946),
////                        infoWindowText: InfoWindowText('current Location', 'Bangalore')
////                      )
////                  );
//                myController.animateCamera(CameraUpdate.newCameraPosition(
//                  CameraPosition(
//                    bearing: 901.0,
//                    target: LatLng(
//                      12.2958, 76.6394,
//                    ),
//                    tilt: 30.0,
//                    zoom: 16.0,
//                  ),
//                ),
//               );
//                myController.addMarker(
//                      MarkerOptions(
//                        draggable: false,
//                        position: LatLng( 12.2958, 76.6394),
//                        infoWindowText: InfoWindowText('current Location', 'Bangalore')
//                      )
//                  );
//                }, child: new Column(
//                  children: <Widget>[
//                    new Text('Navigate', style: textsmallregular(), textAlign: TextAlign.end,),
//                    Padding(padding: EdgeInsetsDirectional.only(top:5.0)),
//                    new Padding(padding: EdgeInsets.only(right: 10.0), child: new Image.asset('assets/icons/navigate.png',),)
//                  ],
//                ),)),
                    ],
                  ))),
          new Positioned(
              bottom: screenHeight * 0.0001,
              child: new Container(
                color: Colors.white,
                width: screenWidth,
                height: 50.0,
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: new Row(
                  children: <Widget>[
                    new Image.asset('assets/icons/watch.png'),
                    new Text('20 min', style: textboldblack()),
                    new Padding(padding: EdgeInsets.only(left: 30.0)),
                    Expanded(
                        child: new Row(
                      children: <Widget>[
                        new Image.asset('assets/icons/send.png'),
                        new Text('22 km', style: textboldblack()),
                      ],
                    ))
                  ],
                ),
              ))
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
                            'Confirmation',
                            style: textmediumb(),
                          ),
                          new Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: new Text(
                              'are you sure you Arrived at Restaurant',
                              style: textblackc(),
                            ),
                          ),
//
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              FlatButton(
                                child: Text(
                                  'CANCEL',
                                  style: textmediumblue(),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                              ),
                              FlatButton(
                                child: Text(
                                  'CONFIRM',
                                  style: textmediumblue(),
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(OrderPlaced.tag);
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
              "Arrived at Restaurant",
              textAlign: TextAlign.center,
              style: textwhitesmall(),
            ),
          )),
    );
  }
}
