import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:async_loader/async_loader.dart';
import 'package:intl/intl.dart';
import './tabs-heading.dart';

import '../../services/orders-service.dart';

class Processing extends StatefulWidget {
  @override
  _ProcessingState createState() => new _ProcessingState();
}

class _ProcessingState extends State<Processing> {
  int dollars = 114;
  dynamic onTheWayordersList;

  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      GlobalKey<AsyncLoaderState>();

  getOnTheWayOrdersList() async {
    return await OrdersService.getAssignedOrdersListToDeliveryBoy('On the Way');
  }

  @override
  Widget build(BuildContext context) {
    var asyncloader = AsyncLoader(
      key: _asyncLoaderState,
      initState: () async => await getOnTheWayOrdersList(),
      renderLoad: () => Center(
          child: CircularProgressIndicator(
        backgroundColor: primary,
      )),
      renderSuccess: ({data}) {
        if (data.length > 0) {
          onTheWayordersList = data;

          pocessingOrderLength = onTheWayordersList.length;

          return buidNewOnTheWayList(data);
        } else {
          return Container(child: Text("No Processing Order"));
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

  Widget buidNewOnTheWayList(dynamic orders) {
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
                    padding: EdgeInsets.all(25.0),
                    margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    color: Colors.white,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            child: new Text(
                          '#${orders[index]['orderID']}',
                          textAlign: TextAlign.center,
                          style: textmediumsm(),
                        )),
                        Expanded(
                            child: new Text(
                          ' ${orders[index]['productDetails'].length}  items',
                          textAlign: TextAlign.center,
                          style: textmediumsm(),
                        )),
                        Expanded(
                            child: new Text(
                          orders[index]['createdAtTime'] != null
                              ? new DateFormat.yMMMMd("en_US").format(
                                  new DateTime.fromMillisecondsSinceEpoch(
                                      orders[index]['createdAtTime']))
                              : new DateFormat.yMMMMd("en_US").format(
                                  DateTime.parse(
                                      '${orders[index]['createdAt']}')),
                          textAlign: TextAlign.center,
                          style: textmediumsm(),
                        ))
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
