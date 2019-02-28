import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:delivery_app/pages/live-tasks/order-delivered.dart';


class StartDelivery extends StatefulWidget {
  static String tag = "startdelivery-page";
  @override
  _StartDeliveryState createState() => _StartDeliveryState();
}

class _StartDeliveryState extends State<StartDelivery> {
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
         new Image.asset('assets/imgs/map.png', width: screenWidth,),

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
                    Expanded(child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Image.asset('assets/icons/watch.png'),
                   new Text('20 min', style: textboldblack()),
                      ],
                    )),
                    Expanded(child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Image.asset('assets/icons/send.png'),
                        new Text('22 km', style: textboldblack()),
                      ],
                    )),
                    Expanded(child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Image.asset('assets/icons/phone.png'),
                      ],
                    )),
                    Expanded(child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushNamed(OrderDelivered.tag);
                      },
                      child: new Container(
                        height: 50.0,
                        padding: EdgeInsets.only(left: 5.0, right: 5.0),
                        alignment: Alignment.center,
                        color: red,
                        child: new Text('Start Delivery', style: textwhites(),),
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
        padding: EdgeInsets.only(top:20.0, right: 20.0, left: 20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
        new Text('Frank Kumar', style: textmediumb(),),
         new Text('Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed'
            ' diam nonumy eirmod tempor invidunt ut', style: textblack(),),
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Text('Help', textAlign: TextAlign.end, style: textblueblack(),),
                new Padding(padding: EdgeInsets.only(left: 5.0), child:   new Image.asset('assets/icons/headset.png'))

              ],
            )

          ],
        ),
      )
    );
  }
}
