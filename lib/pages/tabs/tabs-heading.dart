import 'package:flutter/material.dart';
import 'new.dart';
import 'processing.dart';
import 'history.dart';
import 'package:delivery_app/styles/styles.dart';
import '../../services/orders-service.dart';

int newOrderLength = 1;
int pocessingOrderLength = 1;

class TabsHeading extends StatefulWidget {
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
    _tabs = [
      new Tab(
        text: "New",
      ),
      new Tab(text: 'Processing '),
      new Tab(text: 'History'),
    ];
    _pages = [new New(), new Processing(), new History()];
    _controller = new TabController(
      length: _tabs.length,
      vsync: this,
    );
  }

  getAcceptedOrders() async {
    assignedList =
        await OrdersService.getAssignedOrdersListToDeliveryBoy('Accepted');
    // print('data in tab $assignedList');
    setState(() {
      newOrderLength = assignedList.length;
    });
  }

  getProcessingOrders() async {
    processingList =
        await OrdersService.getAssignedOrdersListToDeliveryBoy('On the Way');
    setState(() {
      pocessingOrderLength = processingList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          size: const Size.fromHeight(500.0),
          child: new TabBarView(
            controller: _controller,
            children: _pages,
          ),
        ),
      ],
    ));
  }
}
