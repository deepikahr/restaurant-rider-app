import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:async_loader/async_loader.dart';
import '../../services/orders-service.dart';
import 'package:intl/intl.dart';
import 'package:delivery_app/pages/home/drawer.dart';

class Earnings extends StatefulWidget {
  static String tag = "earnings-page";
  @override
  _EarningsState createState() => _EarningsState();
}

class _EarningsState extends State<Earnings> {
  bool val = true;
  int dollar = 120;
  int total;
  String selectedDate;
  int profit = 20;

  List orderList = List();
  int date;
  int month;
  int year;
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      GlobalKey<AsyncLoaderState>();

  getDeliveredOrdersListOnSelectedDate() async {
    var date = DateTime.now();
    return await OrdersService.getDeliveredOrdersEaringHistory(
        date.day, date.month, date.year);
  }

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
    var asyncloader = AsyncLoader(
      key: _asyncLoaderState,
      initState: () async => await getDeliveredOrdersListOnSelectedDate(),
      renderLoad: () => Center(
          child: CircularProgressIndicator(
        backgroundColor: primary,
      )),
      renderSuccess: ({data}) {
        if (data != null && data['orders'].length > 0) {
          print(data['totalOrderEarningCOD']);
          total = data['totalOrderEarningCOD'];

          orderList = data['orders'];
          selectedDate = orderList[0]['createdAt'];
          print(data);
          return buildDeliveredList(selectedDate);
        } else {
          return Container(child: Text("No Earning"));
        }
      },
    );
    return new Scaffold(
      // backgroundColor: Colors.black,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Center(
            child: asyncloader,
          ),
        ],
      ),
    );
  }
  //   return new SingleChildScrollView(
  //       child: new Container(
  //           color: bglight,
  //           child:
  //               //  new Column(
  //               //   crossAxisAlignment: CrossAxisAlignment.start,
  //               //   children: <Widget>[
  //               //     new Container(
  //               //       width: screenWidth,
  //               //       padding: EdgeInsets.only(top:20.0, bottom: 20.0),
  //               //       color: Colors.white,
  //               //       child: new Column(
  //               //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               //         children: <Widget>[
  //               //           new Text('Total Earnings for ' , style: textsmallregular(),),
  //               //           new Padding(padding: EdgeInsets.only(top:5.0)),
  //               //           new Text(new DateFormat.yMMMMd("en_US").add_jm().format(DateTime.parse('${orderList[0]['createdAt'] }')), overflow: TextOverflow.ellipsis, style: textlight(),),
  //               //           new Padding(padding: EdgeInsets.only(top:10.0)),
  //               //           new Text('\$ ${total.toStringAsFixed(2)}', style: textred(),)
  //               //         ],
  //               //       ),
  //               //     ),
  //               //     new Padding(padding: EdgeInsets.only(top:10.0, bottom: 10.0, right: 20.0, left: 20.0), child:
  //               //     new Text('Earning Details',  style: textlight()),),

  //               //     new Container(
  //               //         color: Colors.white,
  //               //         child: new Column(
  //               //           children: <Widget>[
  //               asyncloader

  //           //             ],
  //           //           )
  //           //       ),
  //           //     ],
  //           //   ),
  //           ));
  // }

  Widget buildDeliveredList(selectedDate) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
          color: Colors.white,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                'Total Earnings for ',
                style: textsmallregular(),
              ),
              new Padding(padding: EdgeInsets.only(top: 5.0)),
              new Text(
                DateFormat.yMMMMd("en_US")
                    .format(DateTime.parse('$selectedDate')),
                overflow: TextOverflow.ellipsis,
                style: textlight(),
              ),
              new Padding(padding: EdgeInsets.only(top: 10.0)),
              new Text(
                '\$ ${total.toStringAsFixed(2)}',
                style: textred(),
              )
            ],
          ),
        ),
        new Padding(
          padding:
              EdgeInsets.only(top: 10.0, bottom: 10.0, right: 20.0, left: 20.0),
          child: new Text('Earning Details', style: textlight()),
        ),
        new Container(
            color: Colors.white,
            child: new Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    ListView.builder(
                      itemCount: orderList.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (BuildContext contex, int index) {
                        return Column(
                          children: <Widget>[
                            new Row(
                              children: <Widget>[
                                Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: new Image.network(orderList[index]
                                        ['productDetails'][0]['imageUrl'])),
                                Flexible(
                                  flex: 5,
                                  fit: FlexFit.tight,
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Padding(
                                        padding: EdgeInsets.only(left: 4.0),
                                        child: orderList[index]
                                                    ['restaurantName'] !=
                                                null
                                            ? new Text(
                                                orderList[index]
                                                    ['restaurantName'],
                                                style: textmediumb(),
                                              )
                                            : Text(""),
                                      ),
                                      IntrinsicHeight(
                                          child: new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          new Text(
                                            'Order - #${orderList[index]['orderID']}',
                                            style: textdblack(),
                                          ),
                                          // VerticalDivider,
                                          Padding(
                                            padding: EdgeInsets.only(left: 5.0),
                                            child: new Text(
                                              new DateFormat.yMMMMd("en_US")
                                                  .format(DateTime.parse(
                                                      '${orderList[index]['createdAt']}')),
                                              overflow: TextOverflow.ellipsis,
                                              style: textdblack(),
                                            ),
                                          ),
                                        ],
                                      )),
                                    ],
                                  ),
                                ),
                                Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: new Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: new Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          new Text(
                                            '\$${(orderList[index]['grandTotal'])}',
                                            style: textboldsmall(),
                                          ),
                                          new Padding(
                                              padding: EdgeInsets.all(3.0)),
                                          // new Text('Profit \$$profit .5', style: textdblack(),),
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                )
              ],
            )),
      ],
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
