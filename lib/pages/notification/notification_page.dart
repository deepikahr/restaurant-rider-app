import 'package:delivery_app/main.dart';
import 'package:delivery_app/pages/live-tasks/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/services/profile-service.dart';
import 'package:delivery_app/styles/styles.dart';

class NotificationPage extends StatefulWidget {
  final Map<String, Map<String, String>> localizedValues;
  final String locale;
  final int orderId;

  const NotificationPage(
      {Key key, this.orderId, this.localizedValues, this.locale})
      : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool isLoading = false;

  @override
  void initState() {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    ProfileService.getOrderByOrderId(widget.orderId.toString()).then((value) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      if (value["res_code"] == 200) {
        _showDialog(
            orderId: value["res_data"]["data"]["orderID"].toString(),
            restaurantName: value["res_data"]["data"]["restaurantName"],
            id: value["res_data"]["data"]["_id"]);
      }
    }).catchError((error) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      goToHome();
    });
    super.initState();
  }

  goToHome() {
    main();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: isLoading
            ? CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(primary),
              )
            : Container(),
      ),
    ));
  }

  void _showDialog({orderId, restaurantName, id}) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomDialogForConfirmation(
            context: context,
            orderId: orderId,
            restaurantName: restaurantName,
            id: id,
          );
        });
  }
}

class HomeNotification extends StatefulWidget {
  final Map<String, Map<String, String>> localizedValues;
  final String locale;

  const HomeNotification({Key key, this.localizedValues, this.locale})
      : super(key: key);

  @override
  _HomeNotificationState createState() => _HomeNotificationState();
}

class _HomeNotificationState extends State<HomeNotification> {
  bool isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () async {
      goToHome();
    });
    super.initState();
  }

  goToHome() {
    main();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading ? CircularProgressIndicator() : Container(),
      ),
    );
  }
}
