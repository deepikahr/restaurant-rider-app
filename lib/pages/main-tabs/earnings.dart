import 'package:delivery_app/services/localizations.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:async_loader/async_loader.dart';
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
  int total;
  String selectedDate;

  List orderList = List();
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      GlobalKey<AsyncLoaderState>();

  getDeliveredOrdersListOnSelectedDate() async {
    var date = DateTime.now();
    return await OrdersService.getDeliveredOrdersEaringHistory(
        date.day, date.month, date.year);
  }

  @override
  Widget build(BuildContext context) {
    var asyncloader = AsyncLoader(
      key: _asyncLoaderState,
      initState: () async => await getDeliveredOrdersListOnSelectedDate(),
      renderLoad: () => Center(
          child: CircularProgressIndicator(
        backgroundColor: primary,
      )),
      renderSuccess: ({data}) {
        if (data != null && data['orders'].length > 0) {
          total = data['totalOrderEarningCOD'];

          orderList = data['orders'];
          selectedDate = orderList[0]['createdAtTime'] == null
              ? orderList[0]['createdAt']
              : orderList[0]['createdAtTime'];
          return buildDeliveredList(selectedDate);
        } else {
          return Container(child: Text(MyLocalizations.of(context).noEarning));
        }
      },
    );
    return new Scaffold(
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
                MyLocalizations.of(context).totalEarningsfor,
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
          child: new Text(MyLocalizations.of(context).earningDetails,
              style: textlight()),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          MyLocalizations.of(context).orderID +
                                              ' - #${orderList[index]['orderID']}',
                                          style: textdblack(),
                                        ),
                                        // VerticalDivider,
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.0),
                                          child: new Text(
                                            orderList[index]['createdAtTime'] !=
                                                    null
                                                ? new DateFormat.yMMMMd("en_US")
                                                    .format(new DateTime
                                                            .fromMillisecondsSinceEpoch(
                                                        orderList[index]
                                                            ['createdAtTime']))
                                                : new DateFormat.yMMMMd("en_US")
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Text(
                                        '\$${(orderList[index]['grandTotal'])}',
                                        style: textboldsmall(),
                                      ),
                                      new Padding(padding: EdgeInsets.all(3.0)),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
