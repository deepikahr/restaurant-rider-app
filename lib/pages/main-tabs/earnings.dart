import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:delivery_app/pages/home/drawer.dart';


class Earnings extends StatefulWidget {
  static String tag = "earnings-page";
  @override
  _EarningsState createState() => _EarningsState();
}

class _EarningsState extends State<Earnings> {
  bool val= true;
  int dollar = 120;
  int total = 567;
  int profit = 20;
  @override
  Widget VerticalDivider = RotatedBox(
    quarterTurns: 1,
    child: Divider(
      color: blacka,
      height: 6.0,
    ),
  );
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return  new SingleChildScrollView(
          child: new Container(
            color: bglight,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  width: screenWidth,
                  padding: EdgeInsets.only(top:20.0, bottom: 20.0),
                  color: Colors.white,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text('Total Earnings for ' , style: textsmallregular(),),
                      new Padding(padding: EdgeInsets.only(top:5.0)),
                      new Text('Saturday 26 January 2018', style: textlight(),),
                      new Padding(padding: EdgeInsets.only(top:10.0)),
                      new Text('\$ $total.00', style: textred(),)
                    ],
                  ),
                ),
                new Padding(padding: EdgeInsets.only(top:10.0, bottom: 10.0, right: 20.0, left: 20.0), child:
                new Text('Earning Details',  style: textlight()),),

                new Container(
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            Flexible(
                                flex:2,
                                fit: FlexFit.tight,
                                child: new Image.asset('assets/imgs/ricebowl.png')),
                            Flexible(
                              flex:5,
                              fit: FlexFit.tight,
                              child:new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Padding(padding: EdgeInsets.only(left: 4.0), child:
                                  new Text('Goli Vadapav', style: textmediumb(),),),
                                  IntrinsicHeight(
                                      child: new Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          new Text('Order - #2345 ', style: textdblack(),),
                                          VerticalDivider,
                                          new Text('1 Hour ago', style: textdblack(),),

                                        ],
                                      ))
                                ],
                              ),
                            ),
                            Flexible(
                                flex:3,
                                fit: FlexFit.tight,
                                child:new Padding(padding: EdgeInsets.only(right: 10.0), child:
                                new Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text('\$$dollar', style: textboldsmall(),),
                                    new Padding(padding: EdgeInsets.all(3.0)),
                                    new Text('Profit \$$profit .5', style: textdblack(),),
                                  ],
                                ),)
                            )
                          ],
                        ),
                        new Divider(),
                        new Row(
                          children: <Widget>[
                            Flexible(
                                flex:2,
                                fit: FlexFit.tight,
                                child: new Image.asset('assets/imgs/ricebowl.png')),
                            Flexible(
                              flex:5,
                              fit: FlexFit.tight,
                              child:new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Padding(padding: EdgeInsets.only(left: 4.0), child:
                                  new Text('Goli Vadapav', style: textmediumb(),),),
                                  IntrinsicHeight(
                                      child: new Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          new Text('Order - #2345 ', style: textdblack(),),
                                          VerticalDivider,
                                          new Text('1 Hour ago', style: textdblack(),),

                                        ],
                                      ))
                                ],
                              ),
                            ),
                            Flexible(
                                flex:3,
                                fit: FlexFit.tight,
                                child:new Padding(padding: EdgeInsets.only(right: 10.0), child:
                                new Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text('\$$dollar', style: textboldsmall(),),
                                    new Padding(padding: EdgeInsets.all(3.0)),
                                    new Text('Profit \$$profit .5', style: textdblack(),),
                                  ],
                                ),)
                            )
                          ],
                        ),
                        new Divider(),
                        new Row(
                          children: <Widget>[
                            Flexible(
                                flex:2,
                                fit: FlexFit.tight,
                                child: new Image.asset('assets/imgs/ricebowl.png')),
                            Flexible(
                              flex:5,
                              fit: FlexFit.tight,
                              child:new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Padding(padding: EdgeInsets.only(left: 4.0), child:
                                  new Text('Goli Vadapav', style: textmediumb(),),),
                                  IntrinsicHeight(
                                      child: new Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          new Text('Order - #2345 ', style: textdblack(),),
                                          VerticalDivider,
                                          new Text('1 Hour ago', style: textdblack(),),

                                        ],
                                      ))
                                ],
                              ),
                            ),
                            Flexible(
                                flex:3,
                                fit: FlexFit.tight,
                                child:new Padding(padding: EdgeInsets.only(right: 10.0), child:
                                new Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text('\$$dollar', style: textboldsmall(),),
                                    new Padding(padding: EdgeInsets.all(3.0)),
                                    new Text('Profit \$$profit .5', style: textdblack(),),
                                  ],
                                ),)
                            )
                          ],
                        ),


                      ],
                    )
                ),
              ],
            ),
          )
        );

  }

//  void something(bool e) {
//    setState(() {
//      if (e){
//        message = 'yes';
//        val=true;
//        e = true;
//      } else{
//        message = 'No';
//        val = false;
//      }
//    });
//  }
}
