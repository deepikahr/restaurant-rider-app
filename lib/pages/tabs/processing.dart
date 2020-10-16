import 'package:delivery_app/pages/live-tasks/order-delivered.dart';
import 'package:delivery_app/services/localizations.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './tabs-heading.dart';
import '../../services/orders-service.dart';

class Processing extends StatefulWidget {
  final Map<String, Map<String, String>> localizedValues;
  final String locale;

  Processing({Key key, this.locale, this.localizedValues}) : super(key: key);

  @override
  _ProcessingState createState() => new _ProcessingState();
}

class _ProcessingState extends State<Processing> {
  int dollars = 114;
  dynamic onTheWayordersList;
  bool isProcessingLoading = false;

  String currency;

  @override
  void initState() {
    getOnTheWayOrdersList();
    getCurrency();
    super.initState();
  }

  getOnTheWayOrdersList() async {
    if (mounted) {
      setState(() {
        isProcessingLoading = true;
      });
    }

    await OrdersService.getAssignedOrdersListToDeliveryBoy('On the Way')
        .then((value) {
      if (mounted) {
        setState(() {
          isProcessingLoading = false;
        });
        setState(() {
          onTheWayordersList = value['response_data']['data'];

          pocessingOrderLength = onTheWayordersList.length;
          isProcessingLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          isProcessingLoading
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: primary,
                  ),
                )
              : ((onTheWayordersList?.length ?? 0) > 0)
                  ? buidNewOnTheWayList(onTheWayordersList)
                  : Center(
                      child:
                          Text(MyLocalizations.of(context).noProcessingOrder),
                    ),
        ],
      ),
    );
  }

  Widget buidNewOnTheWayList(dynamic orders) {
    return ListView(
      children: <Widget>[
        ListView.builder(
          itemCount: orders.length,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => OrderDelivered(
                        orderDetail: onTheWayordersList[index],
                        locale: widget.locale,
                        localizedValues: widget.localizedValues,
                        currency: currency),
                  ),
                );
              },
              child: Column(
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
                          ' ${orders[index]['productDetails'].length} ' +
                              MyLocalizations.of(context).items,
                          textAlign: TextAlign.center,
                          style: textmediumsm(),
                        )),
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
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }

  void getCurrency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currency = prefs.getString('currency');
  }
}
