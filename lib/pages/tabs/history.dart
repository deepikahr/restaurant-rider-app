import 'package:delivery_app/services/localizations.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:async_loader/async_loader.dart';
import 'package:intl/intl.dart';
import '../../services/orders-service.dart';

class History extends StatefulWidget {
  final Map<String, Map<String, String>> localizedValues;
  final String locale;

  History({Key key, this.locale, this.localizedValues}) : super(key: key);
  @override
  _HistoryState createState() => new _HistoryState();
}

class _HistoryState extends State<History> {
  TextEditingController editingController = TextEditingController();
  TextEditingController controller = new TextEditingController();
  String data = "Hero";
  int orderId, searchOrderId;
  List orderDataList,
      deliveredOrderList,
      orderList,
      searchOrderDataList,
      searchDeliveredOrderList,
      searchOrderList;
  bool isGetHidtoryLoading = false;

  @override
  void initState() {
    getDeliveredOrdersListOnSelectedDate();
    super.initState();
  }

  getDeliveredOrdersListOnSelectedDate() async {
    if (mounted) {
      setState(() {
        isGetHidtoryLoading = true;
      });
    }

    await OrdersService.getAssignedOrdersListToDeliveryBoy('Delivered')
        .then((value) {
      if (mounted) {
        setState(() {
          deliveredOrderList = value['response_data']['data'];
          isGetHidtoryLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bglight,
      body: isGetHidtoryLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: primary,
              ),
            )
          : deliveredOrderList.length > 0
              ? Container(child: buildDeliveredList(deliveredOrderList))
              : Center(
                  child: Text(MyLocalizations.of(context).noHistory),
                ),
    );
  }

  Widget buildDeliveredList(data) {
    return ListView.builder(
      itemCount: data.length,
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
                    ' ${deliveredOrderList[index]['productDetails'].length} ' +
                        MyLocalizations.of(context).items,
                    textAlign: TextAlign.center,
                    style: textmediumsm(),
                  )),
                  Expanded(
                    child: new Text(
                      deliveredOrderList[index]['createdAtTime'] == null
                          ? ""
                          : DateFormat('dd-MMM-yy hh:mm a').format(
                              new DateTime.fromMillisecondsSinceEpoch(
                                  deliveredOrderList[index]['createdAtTime'])),
                      textAlign: TextAlign.center,
                      style: textmediumsm(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
