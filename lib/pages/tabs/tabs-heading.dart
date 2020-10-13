import 'package:delivery_app/services/localizations.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../services/orders-service.dart';
import 'history.dart';
import 'new.dart';
import 'processing.dart';

int newOrderLength = 1;
int pocessingOrderLength = 1;

class TabsHeading extends StatefulWidget {
  final Map<String, Map<String, String>> localizedValues;
  final String locale;

  TabsHeading({Key key, this.locale, this.localizedValues}) : super(key: key);

  @override
  _TabsHeadingState createState() => new _TabsHeadingState();
}

class _TabsHeadingState extends State<TabsHeading>
    with TickerProviderStateMixin {
  dynamic assignedList;
  List processingList = List();
  List<Tab> _tabs;
  List<Widget> _pages;
  TabController _controller;

  @override
  initState() {
    super.initState();
    getAcceptedOrders();
  }

  getAcceptedOrders() async {
    assignedList =
        await OrdersService.getAssignedOrdersListToDeliveryBoy('Accepted');
    if (mounted) {
      setState(() {
        newOrderLength = assignedList.length;
      });
    }
  }

  getProcessingOrders() async {
    processingList =
        await OrdersService.getAssignedOrdersListToDeliveryBoy('On the Way');
    if (mounted) {
      setState(() {
        pocessingOrderLength = processingList.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _tabs = [
      new Tab(
        text: MyLocalizations.of(context).nEW,
      ),
      new Tab(text: MyLocalizations.of(context).processing),
      new Tab(text: MyLocalizations.of(context).history),
    ];
    _pages = [
      new New(
        locale: widget.locale,
        localizedValues: widget.localizedValues,
      ),
      new Processing(
        locale: widget.locale,
        localizedValues: widget.localizedValues,
      ),
      new History(
        locale: widget.locale,
        localizedValues: widget.localizedValues,
      )
    ];
    _controller = new TabController(
      initialIndex: 1,
      length: _tabs.length,
      vsync: this,
    );
    return new Container(
      child: new Column(
        children: [
          new TabBar(
            controller: _controller,
            tabs: _tabs,
            isScrollable: true,
            indicatorColor: primary,
            labelColor: blackb,
            indicatorWeight: 3.0,
            unselectedLabelColor: blackb,
            labelStyle: textmediumsmall(),
            unselectedLabelStyle: textmediumsmall(),
          ),
          new SizedBox.fromSize(
            size: const Size.fromHeight(600.0),
            child: new TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _controller,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }
}
