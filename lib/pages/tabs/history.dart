import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:async_loader/async_loader.dart';
import 'package:intl/intl.dart';
import '../../services/orders-service.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => new _HistoryState();
}

class _HistoryState extends State<History> {
  int dollars = 114;
  String data = "Hero";
  int orderId, searchOrderId;
  List orderDataList = List();
  List deliveredOrderList = List();
  List orderList = List();
  List searchOrderDataList = List();
  List searchDeliveredOrderList = List();
  List searchOrderList = List();
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      GlobalKey<AsyncLoaderState>();

  getDeliveredOrdersList() async {
    return await OrdersService.getAssignedOrdersListToDeliveryBoy('Delivered');
  }

  TextEditingController editingController = TextEditingController();
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    AsyncLoader asyncloader = AsyncLoader(
      key: _asyncLoaderState,
      initState: () async => await getDeliveredOrdersList(),
      renderLoad: () => Center(
          child: CircularProgressIndicator(
        backgroundColor: primary,
      )),
      renderSuccess: ({data}) {
        if (data.length > 0) {
          deliveredOrderList = data;
          orderList = data;
          return buildDeliveredList(data);
        } else {
          return Container(child: Text("No History"));
        }
      },
    );
    return Scaffold(
        backgroundColor: bglight,
        body: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      onChanged: (String value) {
                        setState(() {
                          searchOrderId = int.parse(value);
                        });
                        if (value.length == 5) {
                          for (int i = 0; i < orderList.length; i++) {
                            if (orderList[i]['orderID'] == searchOrderId) {

                              searchOrderDataList = [];
                              searchOrderDataList.add(orderList[i]);
                              searchDeliveredOrderList = searchOrderDataList;
                              setState(() {
                                data = "Zero";
                                searchDeliveredOrderList = searchOrderDataList;
                              });
                              return;
                            } else {
                             
                            }
                          }
                        } else {
                          setState(() {
                            searchOrderDataList = [];
                            deliveredOrderList = orderList;
                          });
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Search",
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                    ),
                  ),
                ),

                // new Container(
                //   margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
                //   decoration: BoxDecoration(
                //       border: Border.all(
                //           color: Color(0xFF707070).withOpacity(0.46)),
                //       borderRadius: BorderRadius.all(Radius.circular(50.0))),
                //   child: new Row(
                //     children: <Widget>[
                //       // Flexible(
                //       //     flex: 1,
                //       //     fit: FlexFit.tight,
                //       //     child: new Icon(Icons.search)),
                //       // Flexible(
                //       //   flex: 4,
                //       //   fit: FlexFit.tight,
                //       //   child: new TextField(
                //       //     decoration: new InputDecoration(
                //       //       labelStyle: TextStyle(color: Colors.grey),
                //       //       border: InputBorder.none,
                //       //     ),
                //       //     style: TextStyle(
                //       //       color: Colors.black54,
                //       //       fontSize: 12.0,
                //       //     ),
                //       //     keyboardType: TextInputType.phone,
                //       //     onChanged: (String value) {
                //       //       setState(() {
                //       //         searchOrderId = int.parse(value);
                //       //       });
                //       //       if (value.length == 5) {
                //       //         for (int i = 0; i < orderList.length; i++) {
                //       //           if (orderList[i]['orderID'] == searchOrderId) {

                //       //             searchOrderDataList = [];
                //       //             searchOrderDataList.add(searchOrderList[i]);
                //       //             searchDeliveredOrderList =
                //       //                 searchOrderDataList;
                //       //             setState(() {
                //       //               data = "Zero";
                //       //               searchDeliveredOrderList =
                //       //                   searchOrderDataList;
                //       //             });
                //       //             searchBuildDeliveredList(
                //       //                 searchDeliveredOrderList);
                //       //             break;
                //       //           } else {
                //       //             return buildDeliveredList(data);
                //       //           }
                //       //         }
                //       //       }
                //       //     },
                //       //   ),
                //       // ),
                //     ],
                //   ),
                // ),
                Center(child: asyncloader),
              ],
            )
          ],
        ));
  }

  Widget buildDeliveredList(dynamic data) {

    return Column(
      children: <Widget>[
        searchOrderDataList.length != 0 || controller.text.isNotEmpty
            ? ListView.builder(
                itemCount: searchDeliveredOrderList.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      new Container(
                        padding: EdgeInsets.all(25.0),
                        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                        color: Colors.white,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                child: new Text(
                              '#${searchDeliveredOrderList[index]['orderID']}',
                              textAlign: TextAlign.center,
                              style: textmediumsm(),
                            )),
                            Expanded(
                                child: new Text(
                              ' ${searchDeliveredOrderList[index]['productDetails'].length}  items',
                              textAlign: TextAlign.center,
                              style: textmediumsm(),
                            )),
                            Expanded(
                                child: new Text(
                                   searchDeliveredOrderList[index]['createdAtTime'] != null
                              ? new DateFormat.yMMMMd("en_US").format(
                                  new DateTime.fromMillisecondsSinceEpoch(
                                      searchDeliveredOrderList[index]['createdAtTime']))
                              : new DateFormat.yMMMMd("en_US").format(
                                  DateTime.parse(
                                      '${searchDeliveredOrderList[index]['createdAt']}')),
                             
                              textAlign: TextAlign.center,
                              style: textmediumsm(),
                            )),
                            // Expanded(child: new Icon(Icons.keyboard_arrow_right))
                          ],
                        ),
                      ),
                    ],
                  );
                })
            : ListView.builder(
                itemCount: deliveredOrderList.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      new Container(
                        padding: EdgeInsets.all(25.0),
                        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                        color: Colors.white,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                child: new Text(
                              '#${deliveredOrderList[index]['orderID']}',
                              textAlign: TextAlign.center,
                              style: textmediumsm(),
                            )),
                            Expanded(
                                child: new Text(
                              ' ${deliveredOrderList[index]['productDetails'].length}  items',
                              textAlign: TextAlign.center,
                              style: textmediumsm(),
                            )),
                            Expanded(
                                child: new Text(
                                      deliveredOrderList[index]['createdAtTime'] != null
                              ? new DateFormat.yMMMMd("en_US").format(
                                  new DateTime.fromMillisecondsSinceEpoch(
                                      deliveredOrderList[index]['createdAtTime']))
                              : new DateFormat.yMMMMd("en_US").format(
                                  DateTime.parse(
                                      '${deliveredOrderList[index]['createdAt']}')),
                            
                              textAlign: TextAlign.center,
                              style: textmediumsm(),
                            )),
                            // Expanded(child: new Icon(Icons.keyboard_arrow_right))
                          ],
                        ),
                      ),
                    ],
                  );
                })
      ],
    );
  }
}
