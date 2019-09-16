import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:async_loader/async_loader.dart';
import '../../services/orders-service.dart';
import 'package:intl/intl.dart';
import './tabs-heading.dart';

class New extends StatefulWidget {
  List orderList = List();
  New({Key key, this.orderList}) : super(key: key);
  @override
  _NewState createState() => new _NewState();
}

class _NewState extends State<New> {
  int dollars = 114;
  dynamic orderList;
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      GlobalKey<AsyncLoaderState>();
  List orderData = List();
  getAcceptedOrdersList() async {
    orderData =
        await OrdersService.getAssignedOrdersListToDeliveryBoy('Accepted');
    setState(() {
      newOrderLength = orderData.length;
    });
    // print('newOrderLength ${orderData.length}');
    return orderData;
  }

  @override
  Widget build(BuildContext context) {
    AsyncLoader asyncloader = AsyncLoader(
      key: _asyncLoaderState,
      initState: () async => await getAcceptedOrdersList(),
      renderLoad: () => CircularProgressIndicator(),
      renderSuccess: ({data}) {
        if (data.length > 0) {
          orderList = data;
          // print('newOrderLength newOrderLength $newOrderLength');
          return buidNewOrdersList(data);
        } else {
          return Container(child: Text("No New Order"));
        }
      },
    );

    return Scaffold(
      backgroundColor: bglight,
      body:
          Container(alignment: AlignmentDirectional.center, child: asyncloader),
    );
  }

  Widget buidNewOrdersList(dynamic orders) {
    return Column(
      children: <Widget>[
        ListView.builder(
          itemCount: orders.length,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                new Container(
                  padding:
                      EdgeInsets.only(left: 25.0, right: 25.0, bottom: 25.0),
                  margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  color: Colors.white,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        margin:
                            EdgeInsets.only(left: 26.0, top: 5.0, bottom: 5.0),
                        padding: EdgeInsets.only(
                            top: 3.0, bottom: 3.0, right: 16.0, left: 16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          color: red,
                        ),
                        child: new Text(
                          'Modified',
                          style: textsmwhite(),
                        ),
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: new Text(
                              '#${orders[index]['orderID']}',
                              textAlign: TextAlign.center,
                              style: textmediumsm(),
                            ),
                          ),
                          Expanded(
                            child: new Text(
                              ' ${orders[index]['productDetails'].length}  items',
                              textAlign: TextAlign.center,
                              style: textmediumsm(),
                            ),
                          ),
                          Expanded(
                            child: new Text(
                              new DateFormat.yMMMMd("en_US").add_jm().format(
                                  DateTime.parse(
                                      '${orders[index]['createdAt']}')),
                              textAlign: TextAlign.center,
                              style: textmediumsm(),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        )
      ],
    );
  }
}
