import 'package:delivery_app/services/localizations.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatefulWidget {
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
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: primary,
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
                widget.orderDetail['userInfo']['name'] ?? '',
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
                  '${widget?.orderDetail['shippingAddress'].toString().contains('address') ? widget?.orderDetail['shippingAddress']['address'] : ''}',
                  style: textmediumblack(),
                ),
              ),
              Text(
                '${MyLocalizations.of(context).items}:',
                style: textmediumboldblack(),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.orderDetail['productDetails'].length ?? 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        '${widget.orderDetail['productDetails'][index]['title']}  X ${widget.orderDetail['productDetails'][index]['Quantity']}',
                        style: textmediumblack(),
                      ),
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              buildTile(context, MyLocalizations.of(context).orderID,
                  widget.orderDetail['orderID'].toString()),
              buildTile(context, MyLocalizations.of(context).restaurant,
                  widget.orderDetail['productDetails'][0]['restaurant']),
              buildTile(
                  context,
                  MyLocalizations.of(context).createdAt,
                  DateFormat.yMd()
                      .add_jm()
                      .format(DateTime.parse(widget.orderDetail['createdAt']))),
              buildTile(context, MyLocalizations.of(context).deliveryType,
                  widget.orderDetail['orderType'].toString()),
              buildTile(context, MyLocalizations.of(context).paymentMode,
                  widget.orderDetail['paymentOption'].toString()),
              buildTile(context, MyLocalizations.of(context).subTotal,
                  widget.orderDetail['subTotal'].toString()),
              buildTile(context, MyLocalizations.of(context).deliveryCharges,
                  widget.orderDetail['deliveryCharge'].toString()),
              buildTile(context, MyLocalizations.of(context).total,
                  widget.orderDetail['grandTotal'].toString()),
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
                    ? '${widget.currency ?? ''} ${value?.toString() ?? ''}'
                    : value?.toString() ?? '',
            style: textmediumblack(),
          )
        ],
      ),
    );
  }
}
