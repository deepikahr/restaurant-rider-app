import 'package:delivery_app/services/localizations.dart';
import 'package:delivery_app/services/orders-service.dart';
import 'package:delivery_app/services/profile-service.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:delivery_app/main.dart';

class CustomDialogForConfirmation extends StatefulWidget {
  final Map<String, Map<String, String>> localizedValues;
  final String locale;
  final VoidCallback listener;
  final String id;
  final String orderId;
  final String restaurantName;
  final bool isImage;
  final VoidCallback declineListener;
  final bool showCancel;
  final BuildContext context;

  const CustomDialogForConfirmation({
    Key key,
    @required this.listener,
    @required this.orderId,
    this.showCancel = true,
    this.isImage = true,
    this.restaurantName,
    this.declineListener,
    this.localizedValues,
    this.locale,
    this.context,
    this.id,
  }) : super(key: key);

  @override
  _CustomDialogForConfirmationState createState() =>
      _CustomDialogForConfirmationState();
}

class _CustomDialogForConfirmationState
    extends State<CustomDialogForConfirmation> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        child: Container(
          child: isLoading
              ? SizedBox(
                  height: 200,
                  child: Center(
                      child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(primary),
                  )))
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      height: 80,
                      color: primary,
                      child: Center(
                          child: Text(
                        MyLocalizations.of(context).newOrders,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          buildItemTile(MyLocalizations.of(context).orderID,
                              widget.orderId),
                          buildItemTile(
                              MyLocalizations.of(context).restaurant +
                                  MyLocalizations.of(context).name,
                              widget.restaurantName),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              widget.showCancel
                                  ? SizedBox(
                                      width: 80,
                                      child: FlatButton(
                                        padding: EdgeInsets.all(0),
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        onPressed: () {
                                          if (widget.declineListener != null) {
                                            widget.declineListener();
                                          } else {
                                            goToHome();
                                          }
                                        },
                                        child: Text(
                                          MyLocalizations.of(context)
                                              .reject
                                              .toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              SizedBox(
                                width: 80,
                                child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  onPressed: () async {
                                    if (mounted) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                    }
                                    await ProfileService.getUserInfo()
                                        .then((value) {
                                      var body = {
                                        "deliveryByName ": value['name'],
                                        "deliveryBy": value['_id'],
                                        "assignedDate":
                                            DateTime.now().toString(),
                                        "assigned": true.toString()
                                      };
                                      assignOrder(body, widget.id);
                                    });
                                  },
                                  child: Text(
                                    MyLocalizations.of(context)
                                        .accept
                                        .toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  goToHome() {
    main();
  }

  assignOrder(deliveryBoyDetails, id) async {
    await OrdersService.assignOrder(deliveryBoyDetails, id).then((value) {
      print(value);
      if (value['res_code'] == 200) {
        widget.listener();
        goToHome();
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        showSnackbar(value['message'].toString());
      } else if (value['res_code'] == 400) {
        goToHome();
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        showSnackbar(value['message']);
      }
    }).catchError((error) {
      goToHome();
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  void showSnackbar(message) {
    Toast.show(message.toString(), context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.white,
        textColor: primary);
  }

  buildItemTile(title, value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text('$title :',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
                color: Colors.black,
                fontFamily: 'RobotoMedium',
              )),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w100,
              fontSize: 16.0,
              color: Colors.black,
              fontFamily: 'RobotoMedium',
            ),
          ),
        ),
      ],
    );
  }
}
