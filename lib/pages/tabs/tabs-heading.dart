import 'package:flutter/material.dart';
import 'new.dart';
import 'processing.dart';
import 'history.dart';
import 'package:delivery_app/styles/styles.dart';
import '../../services/orders-service.dart';

class TabsHeading extends StatefulWidget {
  @override
  _TabsHeadingState createState() => new _TabsHeadingState();
}

class _TabsHeadingState extends State<TabsHeading>
    with TickerProviderStateMixin {
  List<dynamic> assignedList;
  List<dynamic> processingList;
  List<Tab> _tabs;
  List<Widget> _pages;
  TabController _controller;

  @override
  initState() {
    super.initState();

    _tabs = [
      new Tab(
        text: "New (3)",
      ),
      new Tab(text: 'Processing (0)'),
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
  }

  getProcessingOrders() async {
    processingList =
        await OrdersService.getAssignedOrdersListToDeliveryBoy('On the Way');
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
