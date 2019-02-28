import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:delivery_app/pages/live-tasks/start-delivery.dart';


class OrderDelivered extends StatefulWidget {
  static String tag = "orderdelivered-page";
  @override
  _OrderDeliveredState createState() => _OrderDeliveredState();
}

class _OrderDeliveredState extends State<OrderDelivered> {
  bool val= true;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        iconTheme: IconThemeData(color: Colors.white),
        title: new Text('Live Tasks', style: textwhitesmall()),
        actions: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text('Online', textAlign: TextAlign.end, style: textwhite(),),
              new Switch(value: val,
                  activeColor: red,
                  activeTrackColor: darkgreen,
                  onChanged: (bool e) => true),
            ],
          )
        ],
      ),
      body: new Stack(
        children: <Widget>[
          new ListView(
            children: <Widget>[
              new SingleChildScrollView(
                child: new Padding(padding: EdgeInsets.all(20.0), child: new Column(
                  children: <Widget>[
                    new Text('Lorem ipsum dolor sit amet, consetetur sadipscing elitr, '
                        'sed diam nonumy eirmod tempor invidunt ut labore et dolore magna', style: textlightblackh()),
                    Padding(padding: EdgeInsets.only(top:20.0)),
                    new Row(
                      children: <Widget>[
                        new Image.asset('assets/icons/cell-phone.png'),
                        new Padding(padding: EdgeInsets.only(left: 15.0)),
                        new Text('Call your Customer', style: textsmallbold(),)
                      ],
                    )
                  ],
                ),)
              )
            ],
          ),

          new Positioned(
//              top:screenHeight * 0.72,
              bottom: screenHeight * 0.0001,
              child: new Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 20.0, right: 20.0, left: 20.0),
                  color: bgcolor,
                  width: screenWidth,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          Expanded(child: new Text('Order id : #1234', style: textdblack(),)),
                          Expanded(child: new Text('Jan 21 , 6:33 pm', textAlign: TextAlign.end, style: textdblack(),))
                        ],
                      ),
                      new Padding(padding: EdgeInsets.only(top:10.0)),
                      new Text('Item(s)', style: textboldblack(),),
                      new Padding(padding: EdgeInsets.only(top:5.0)),
                      new Text('Total Bill : Rs 149', style: textboldblack(),),
                      new Padding(padding: EdgeInsets.only(top:5.0)),
                      new Row(
                        children: <Widget>[
                          new Text('Collect from Customer : Rs 00.00', style: textboldblack(),),
                          Expanded(child: new Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              new Text('Help', textAlign: TextAlign.end, style: textblueblack(),),
                              new Padding(padding: EdgeInsets.only(left: 5.0), child: new Image.asset('assets/icons/headset.png'),)
                            ],
                          ))
                        ],
                      ),
                    ],
                  )
              ) )
        ],

      ),
      bottomNavigationBar: RawMaterialButton(
          onPressed: (){
          },
          child: Container(
            color: redbtn,
            height: 50.0,
            alignment: AlignmentDirectional.center,
            child: Text("Order Delivered",  textAlign: TextAlign.center, style: textwhitesmall(),),
          )
      ),



    );
  }
}
