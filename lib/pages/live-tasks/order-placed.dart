import 'package:delivery_app/pages/live-tasks/start-delivery.dart';
import 'package:delivery_app/services/localizations.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:intl/intl.dart';

class OrderPlaced extends StatefulWidget {
  static String tag = "orderplaced-page";
  final orderDetail;
  final Map<String, Map<String, String>> localizedValues;
  final String locale;

  OrderPlaced({Key key, this.orderDetail, this.locale, this.localizedValues})
      : super(key: key);

  @override
  _OrderPlacedState createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        iconTheme: IconThemeData(color: Colors.white),
        title: new Text(
          MyLocalizations.of(context).liveTasks,
          style: textwhitesmall(),
        ),
      ),
      body: new Stack(
        children: <Widget>[
          new ListView(
            children: <Widget>[
              new SingleChildScrollView(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      color: bgcolor,
                      height: 60.0,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Text(
                            MyLocalizations.of(context).orderisPlaced,
                            style: textmediumb(),
                          ),
                        ],
                      ),
                    ),
                    new Container(
                      padding:
                          EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                      child: ListView.builder(
                          itemCount:
                              widget.orderDetail['productDetails'].length,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return new Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Row(
                                  children: <Widget>[
                                    Expanded(
                                        flex: 7,
                                        child: new Text(
                                          widget.orderDetail['productDetails']
                                                  [index]['title'] +
                                              '(' +
                                              widget.orderDetail[
                                                      'productDetails'][index]
                                                  ['size'] +
                                              ')',
                                          style: textlightblack(),
                                        )),
                                    Expanded(
                                      flex: 1,
                                      child: new Text(
                                        'X ${widget.orderDetail['productDetails'][index]['Quantity']} ',
                                        textAlign: TextAlign.center,
                                        style: textlightblack(),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: new Text(
                                        '\$ ${widget.orderDetail['productDetails'][index]['totalPrice']}',
                                        textAlign: TextAlign.end,
                                        style: textlightblack(),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(padding: EdgeInsets.only(top: 15.0)),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              )
            ],
          ),
          new Positioned(
            bottom: screenHeight * 0.0001,
            child: new Container(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 20.0, right: 20.0, left: 20.0),
              color: bgcolor,
              width: screenWidth,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      Expanded(
                          child: new Text(
                        MyLocalizations.of(context).orderID +
                            ' : #${widget.orderDetail['orderID']}',
                        style: textdblack(),
                      )),
                      Expanded(
                          child: new Text(
                        new DateFormat.yMMMMd("en_US").add_jm().format(
                            DateTime.parse(
                                '${widget.orderDetail['createdAtTime'] != null ? widget.orderDetail['createdAtTime'] : widget.orderDetail['createdAt']}')),
                        textAlign: TextAlign.end,
                        style: textdblack(),
                      ))
                    ],
                  ),
                  new Padding(padding: EdgeInsets.only(top: 10.0)),
                  new Text(
                    MyLocalizations.of(context).orderStatus +
                        ' : ${widget.orderDetail['paymentOption']}',
                    style: textboldblack(),
                  ),
                  new Padding(padding: EdgeInsets.only(top: 5.0)),
                  new Text(
                    MyLocalizations.of(context).totalBill +
                        ' : ${widget.orderDetail['paymentStatus']}',
                    style: textboldblack(),
                  ),
                  new Padding(padding: EdgeInsets.only(top: 5.0)),
                  new Text(
                    MyLocalizations.of(context).totalBill +
                        ' :\$ ${widget.orderDetail['grandTotal']}',
                    style: textboldblack(),
                  ),
                  new Padding(padding: EdgeInsets.only(top: 5.0)),
                  new Text(
                    widget.orderDetail['paymentOption'] == 'COD'
                        ? MyLocalizations.of(context).payGlobalRestaurant +
                            ' : \$ ${widget.orderDetail['grandTotal']}'
                        : ' ',
                    style: textboldblack(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: RawMaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => new StartDelivery(
                orderDetail: widget.orderDetail,
                locale: widget.locale,
                localizedValues: widget.localizedValues,
              ),
            ),
          );
        },
        child: Container(
          color: redbtn,
          height: 50.0,
          alignment: AlignmentDirectional.center,
          child: Text(
            MyLocalizations.of(context).orderPicked,
            textAlign: TextAlign.center,
            style: textwhitesmall(),
          ),
        ),
      ),
    );
  }
}
