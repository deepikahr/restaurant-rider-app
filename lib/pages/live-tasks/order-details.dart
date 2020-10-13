import 'package:delivery_app/services/localizations.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatelessWidget {
  final String currency;
  final Map<String, dynamic> orderDetail;
  final Map<String, Map<String, String>> localizedValues;
  final String locale;

  const OrderDetails(
      {Key key,
      this.orderDetail,
      this.localizedValues,
      this.locale,
      this.currency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            MyLocalizations.of(context).orderDetails,
            style: textboldlargewhite(),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: ListView(
            children: [
              Text(
                orderDetail['userInfo']['name'] ?? '',
                style: textlargeboldblack(),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                '${MyLocalizations.of(context).address}:',
                style: textmediumboldblack(),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 5, right: 3, bottom: 20),
                child: Text(
                  '${orderDetail['shippingAddress']['address'] ?? ''}',
                  style: textmediumblack(),
                ),
              ),
              Text(
                '${MyLocalizations.of(context).items}:',
                style: textmediumboldblack(),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: orderDetail['productDetails'].length ?? 0,
                  itemBuilder: (context, index) {
                    var totalPrice = orderDetail['productDetails'][index]
                            ['price'] *
                        orderDetail['productDetails'][index]['Quantity'];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${orderDetail['productDetails'][index]['title']}  X ${orderDetail['productDetails'][index]['Quantity']}',
                                style: textmediumblack(),
                              ),
                              Text(
                                '$currency ${double.parse(totalPrice.toString()).toStringAsFixed(2)}',
                                style: textmediumblack(),
                              )
                            ],
                          ),
                        ),
                        ((orderDetail['productDetails'][index]
                                            ['extraIngredients']
                                        .length ??
                                    0) >
                                0)
                            ? ListView.builder(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: orderDetail['productDetails'][index]
                                            ['extraIngredients'] !=
                                        null
                                    ? orderDetail['productDetails'][index]
                                            ['extraIngredients']
                                        .length
                                    : 0,
                                itemBuilder: (BuildContext context, int j) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(),
                                          Text(
                                              orderDetail['productDetails']
                                                              [index]
                                                          ['extraIngredients']
                                                      [j]['name'] ??
                                                  '',
                                              style: textmediumblack()),
                                          Text(
                                            '$currency${orderDetail['productDetails'][index]['extraIngredients'][j]['price'].toString()}' ??
                                                '',
                                            style: textmediumblack(),
                                          )
                                        ]),
                                  );
                                })
                            : Container(),
                        Row(
                          children: [
                            orderDetail['productDetails'][index]['note'] != null
                                ? Text(
                                    '${MyLocalizations.of(context).note} :',
                                    style: textmediumboldblack(),
                                  )
                                : Container(),
                            orderDetail['productDetails'][index]['note'] != null
                                ? Expanded(
                                    child: Text(
                                      '  ${orderDetail['productDetails'][index]['note'].toString()}',
                                      style: textmediumblack(),
                                      maxLines: 2,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                        ((orderDetail['productDetails'][index]['flavour']
                                        ?.length ??
                                    0) >
                                0)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${MyLocalizations.of(context).flavour} :',
                                    style: textmediumboldblack(),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: orderDetail['productDetails']
                                                  [index]['flavour']
                                              ?.length ??
                                          0,
                                      itemBuilder: (context, flavourIndex) {
                                        return Text(
                                          '${orderDetail['productDetails'][index]['flavour'][flavourIndex]['flavourName']}  X  ${orderDetail['productDetails'][index]['flavour'][flavourIndex]['quantity']}',
                                          style: textmediumblack(),
                                        );
                                      }),
                                ],
                              )
                            : Container()
                      ],
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              buildTile(context, MyLocalizations.of(context).orderID,
                  orderDetail['orderID'].toString()),
              buildTile(context, MyLocalizations.of(context).restaurant,
                  orderDetail['productDetails'][0]['restaurant']),
              buildTile(
                  context,
                  MyLocalizations.of(context).createdAt,
                  DateFormat.yMd()
                      .add_jm()
                      .format(DateTime.parse(orderDetail['createdAt']))),
              buildTile(context, MyLocalizations.of(context).deliveryType,
                  orderDetail['orderType'].toString()),
              buildTile(context, MyLocalizations.of(context).paymentMode,
                  orderDetail['paymentOption'].toString()),
              buildTile(
                  context,
                  MyLocalizations.of(context).subTotal,
                  double.parse(orderDetail['subTotal'].toString())
                      .toStringAsFixed(2)),
              buildTile(context, MyLocalizations.of(context).deliveryCharges,
                  orderDetail['deliveryCharge'].toString()),
              buildTile(
                  context,
                  MyLocalizations.of(context).total,
                  double.parse(orderDetail['grandTotal'].toString())
                      .toStringAsFixed(2)),
            ],
          ),
        ));
  }

  buildTile(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: textmediumboldblack(),
          ),
          Text(
            (title == MyLocalizations.of(context).orderID)
                ? '#${value?.toString() ?? ''}'
                : (title == MyLocalizations.of(context).total ||
                        title == MyLocalizations.of(context).subTotal ||
                        title == MyLocalizations.of(context).deliveryCharges)
                    ? '${currency ?? ''} ${value?.toString() ?? ''}'
                    : value?.toString() ?? '',
            style: textmediumblack(),
          )
        ],
      ),
    );
  }
}
