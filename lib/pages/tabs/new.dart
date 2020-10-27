import 'package:delivery_app/services/localizations.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './tabs-heading.dart';
import '../../services/orders-service.dart';

class New extends StatefulWidget {
  final orderList;
  final Map<String, Map<String, String>> localizedValues;
  final String locale;

  New({Key key, this.orderList, this.locale, this.localizedValues})
      : super(key: key);

  @override
  _NewState createState() => new _NewState();
}

class _NewState extends State<New> {
  int dollars = 114;
  dynamic orderList;

  List orderData = List();
  bool isGetNewOrderLoading = false;

  @override
  void initState() {
    getAcceptedOrdersList();
    super.initState();
  }

  getAcceptedOrdersList() async {
    if (mounted) {
      setState(() {
        isGetNewOrderLoading = true;
      });
    }

    await OrdersService.getAssignedOrdersListToDeliveryBoy('Accepted')
        .then((value) {
      setState(() {
        isGetNewOrderLoading = false;
      });
      if (mounted) {
        setState(() {
          newOrderLength = orderData.length;
          orderList = value['response_data']['data'];
          isGetNewOrderLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bglight,
      body: Container(
        alignment: AlignmentDirectional.center,
        child: isGetNewOrderLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: primary,
                ),
              )
            : ((orderList?.length ?? 0) > 0)
                ? buidNewOrdersList(orderList)
                : Center(
                    child: Text(MyLocalizations.of(context).noNewOrder),
                  ),
      ),
    );
  }

  Widget buidNewOrdersList(dynamic orders) {
    return ListView(
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
                              ' ${orders[index]['productDetails'].length} ' +
                                  MyLocalizations.of(context).items,
                              textAlign: TextAlign.center,
                              style: textmediumsm(),
                            ),
                          ),
                          Expanded(
                            child: new Text(
                              orders[index]['createdAtTime'] == null
                                  ? ""
                                  : DateFormat('dd-MMM-yy hh:mm a').format(
                                      new DateTime.fromMillisecondsSinceEpoch(
                                          orders[index]['createdAtTime'])),
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
