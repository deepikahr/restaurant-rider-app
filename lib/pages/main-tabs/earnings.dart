import 'package:delivery_app/services/localizations.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:async_loader/async_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/orders-service.dart';
import 'package:intl/intl.dart';

class Earnings extends StatefulWidget {
  final Map<String, Map<String, String>> localizedValues;
  final String locale;

  Earnings({Key key, this.locale, this.localizedValues}) : super(key: key);
  static String tag = "earnings-page";
  @override
  _EarningsState createState() => _EarningsState();
}

class _EarningsState extends State<Earnings> {
  double total;
  String selectedDate;
  bool isGetEarningLoading = false;
  List orderList = List();
  Map earningData;
  String currency;

  getDeliveredOrdersListOnSelectedDate() async {
    if (mounted) {
      setState(() {
        isGetEarningLoading = true;
      });
    }
    var date = DateTime.now();

    await OrdersService.getDeliveredOrdersEaringHistory(
            date.day, date.month, date.year)
        .then((value) {
      if (mounted) {
        setState(() {
          earningData = value;
          isGetEarningLoading = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrency();
    getDeliveredOrdersListOnSelectedDate();
  }

  getCurrency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currency = prefs.getString('currency');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Center(
              child: isGetEarningLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: primary,
                      ),
                    )
                  : earningData['orders'].length > 0
                      ? buildDeliveredList(earningData)
                      : Container(
                          child: Text(MyLocalizations.of(context).noEarning))),
        ],
      ),
    );
  }

  Widget buildDeliveredList(data) {
    return new ListView(
      children: <Widget>[
        new Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
          color: Colors.white,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                MyLocalizations.of(context).totalEarningsfor,
                style: textsmallregular(),
              ),
              new Padding(padding: EdgeInsets.only(top: 5.0)),
              new Text(
                selectedDate = data['orders'][0]['createdAtTime'] == null
                    ? ""
                    : DateFormat('dd-MMM-yy hh:mm a').format(
                        new DateTime.fromMillisecondsSinceEpoch(
                          data['orders'][0]['createdAtTime'],
                        ),
                      ),
                overflow: TextOverflow.ellipsis,
                style: textlight(),
              ),
              new Padding(padding: EdgeInsets.only(top: 10.0)),
              new Text(
                '$currency ${data['totalOrderEarningCOD'].toStringAsFixed(2)}',
                style: textred(),
              )
            ],
          ),
        ),
        new Padding(
          padding:
              EdgeInsets.only(top: 10.0, bottom: 10.0, right: 20.0, left: 20.0),
          child: new Text(MyLocalizations.of(context).earningDetails,
              style: textlight()),
        ),
        new Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                ListView.builder(
                  itemCount: data['orders'].length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext contex, int index) {
                    print(data);
                    print(data['orders'][index]['createdAtTime']);

                    return Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                        children: <Widget>[
                          new Row(
                            children: <Widget>[
                              Flexible(
                                flex: 3,
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Image.network(
                                    data['orders'][index]['productDetails'][0]
                                        ['imageUrl'],
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 5,
                                fit: FlexFit.tight,
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Padding(
                                      padding: EdgeInsets.only(left: 4.0),
                                      child: data['orders'][index]
                                                  ['restaurantName'] !=
                                              null
                                          ? new Text(
                                              data['orders'][index]
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
                                            MyLocalizations.of(context)
                                                    .orderID +
                                                ' - #${data['orders'][index]['orderID']}',
                                            style: textdblack(),
                                          ),
                                          // VerticalDivider,
                                          Padding(
                                            padding: EdgeInsets.only(left: 5.0),
                                            child: new Text(
                                              data['orders'][0]
                                                          ['createdAtTime'] ==
                                                      null
                                                  ? ""
                                                  : DateFormat(
                                                          'dd-MMM-yy hh:mm a')
                                                      .format(new DateTime
                                                          .fromMillisecondsSinceEpoch(data[
                                                              'orders'][index]
                                                          ['createdAtTime'])),
                                              overflow: TextOverflow.ellipsis,
                                              style: textdblack(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: new Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: new Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Text(
                                        '$currency${(data['orders'][index]['grandTotal'])}',
                                        style: textboldsmall(),
                                      ),
                                      new Padding(padding: EdgeInsets.all(3.0)),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Divider()
                        ],
                      ),
                    );
                  },
                ),
              ],
            )),
      ],
    );
  }
}
