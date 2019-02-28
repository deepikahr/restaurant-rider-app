import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:async_loader/async_loader.dart';
import 'package:intl/intl.dart';
import '../../services/orders-service.dart';

class History extends StatelessWidget {
  int dollars = 114;
  dynamic deliveredOrderList;
  final GlobalKey<AsyncLoaderState> _asyncLoaderState = GlobalKey<AsyncLoaderState>();

  getDeliveredOrdersList() async {
    return await OrdersService.getAssignedOrdersListToDeliveryBoy('Delivered');
  }

  @override
  

  Widget build(BuildContext context) {
    AsyncLoader asyncloader = AsyncLoader(
      key: _asyncLoaderState,
      initState: () async => await getDeliveredOrdersList(),
      renderLoad: () => Center(child: CircularProgressIndicator()),
      renderSuccess: ({data}) {
        if (data.length > 0) {
          deliveredOrderList = data;
          return  buildDeliveredList(data);
        }
      },
    );
    return Scaffold(
      backgroundColor: bglight,
      body: ListView(
        children: <Widget>[
          SingleChildScrollView(
              child:  new Column(
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF707070).withOpacity(0.46)),
                      borderRadius: BorderRadius.all(Radius.circular(50.0))
                    ),
                    child:  new Row(
                      children: <Widget>[
                        Flexible(
                            flex:1,
                            fit: FlexFit.tight,
                            child: new Icon(Icons.search)),
                        Flexible(
                          flex:4,
                          fit: FlexFit.tight,
                          child:new TextFormField(
                            decoration: new InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12.0,
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),

                  ),
                  asyncloader
                ],
              )
          ),
        ],
      )

    );
  }

  Widget buildDeliveredList(dynamic orders){
    return Column(
      children: <Widget>[
        ListView.builder(
          itemCount: orders.length,
          shrinkWrap: true,
          physics:ScrollPhysics(),
          itemBuilder:(BuildContext context int index){
            return Column(
              children: <Widget>[
                new Container(
                    padding: EdgeInsets.all(25.0),
                    margin: EdgeInsets.only(top:5.0, bottom: 5.0),
                    color: Colors.white,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(child: new Text('#${orders[index]['orderID']}', textAlign: TextAlign.center, style: textmediumsm(),)),
                        Expanded(child: new Text(' ${orders[index]['productDetails'].length }  items', textAlign: TextAlign.center, style: textmediumsm(),)),
                        Expanded(child: new Text(new DateFormat.yMMMMd("en_US").add_jm().format(DateTime.parse('${orders[index]['createdAt'] }')), textAlign: TextAlign.center, style: textmediumsm(),)),
                        // Expanded(child: new Icon(Icons.keyboard_arrow_right))
                      ],
                    ),
                  ),
              ],
            );
          }
        )
      ],
    );
  }
}