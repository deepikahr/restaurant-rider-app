import 'package:delivery_app/pages/live-tasks/start-delivery.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class OrderPlaced extends StatefulWidget {
  static String tag = "orderplaced-page";
  final orderDetail;
  OrderPlaced({Key key, this.orderDetail}) : super(key: key);

  @override
  _OrderPlacedState createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {
  static File _imageFile, myfile;
  bool val = true;

  void _getImage(BuildContext context, ImageSource source) {
    setState(() {
      _imageFile = myfile;
    });
    ImagePicker.pickImage(
      source: source,
    ).then((File image) {
      setState(() {
        _imageFile = image;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        iconTheme: IconThemeData(color: Colors.white),
        title: new Text('Live Tasks', style: textwhitesmall()),
        actions: <Widget>[
          // new Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     new Text(
          //       'Online',
          //       textAlign: TextAlign.end,
          //       style: textwhite(),
          //     ),
          //     new Switch(
          //         value: val,
          //         activeColor: red,
          //         activeTrackColor: darkgreen,
          //         onChanged: (bool e) => true),
          //   ],
          // )
        ],
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
                            'Order is Placed',
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
                                              "" +
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
                                        ))
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
//              top:screenHeight * 0.72,
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
                            'Order id : #${widget.orderDetail['orderID']}',
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
                        'Order Status : ${widget.orderDetail['paymentOption']}',
                        style: textboldblack(),
                      ),
                      new Padding(padding: EdgeInsets.only(top: 5.0)),
                      new Text(
                        'Total Bill : ${widget.orderDetail['paymentStatus']}',
                        style: textboldblack(),
                      ),
                      new Padding(padding: EdgeInsets.only(top: 5.0)),
                      new Text(
                        'Total Bill :\$ ${widget.orderDetail['grandTotal']}',
                        style: textboldblack(),
                      ),
                      new Padding(padding: EdgeInsets.only(top: 5.0)),
                      new Text(
                        widget.orderDetail['paymentOption'] == 'COD'
                            ? 'Pay Global Restaurant : \$ ${widget.orderDetail['grandTotal']}'
                            : ' ',
                        style: textboldblack(),
                      ),
                      // new Padding(padding: EdgeInsets.only(top: 5.0)),
                      // new Row(
                      //   children: <Widget>[
                      //     new Text(
                      //       widget.orderDetail['paymentOption'] == 'COD'
                      //           ? 'Collect from Customer :\$ ${widget.orderDetail['grandTotal']}'
                      //           : ' ',
                      //       style: textboldblack(),
                      //     ),
                      //     Expanded(
                      //         child: new Row(
                      //       mainAxisAlignment: MainAxisAlignment.end,
                      //       children: <Widget>[
                      //         // new Text(
                      //         //   'Help',
                      //         //   textAlign: TextAlign.end,
                      //         //   style: textblueblack(),
                      //         // ),
                      //         // new Padding(
                      //         //   padding: EdgeInsets.only(left: 5.0),
                      //         //   child:
                      //         //       new Image.asset('assets/icons/headset.png'),
                      //         // )
                      //       ],
                      //     ))
                      //   ],
                      // ),
                    ],
                  )))
        ],
      ),
      bottomNavigationBar: RawMaterialButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new StartDelivery(orderDetail: widget.orderDetail)));
//             showDialog<void>(
//               context: context,
//               barrierDismissible: false, // user must tap button!
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   content: SingleChildScrollView(
//                     child: Container(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           new Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: <Widget>[
//                               Expanded(
//                                 child: new Text(
//                                   'Submit Bill',
//                                   style: textmediumb(),
//                                 ),
//                               ),
//                               Expanded(
//                                   child: new Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: <Widget>[
//                                   GestureDetector(
//                                     onTap: () {
//                                       Navigator.of(context).pop(context);
//                                     },
//                                     child: new Icon(
//                                       Icons.clear,
//                                     ),
//                                   )
//                                 ],
//                               )),
//                             ],
//                           ),
//                           InkWell(child:
//                            new Padding(
//                             padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
//                             child: new Text(
//                               'Camera',
//                               style: textmediumblue(),
//                             ),
//                           )
//                           ,onTap: (){
//                              _getImage(context, ImageSource.camera);
//                           },
//                           ),

//                           new Row(
//                             children: <Widget>[
//                               new Container(
//                                 width: 120.0,
//                                 height: 30.0,
//                                 decoration: BoxDecoration(
//                                     color: bglight,
//                                     border:
//                                         Border.all(color: Color(0xFF38707070))
//                                         ),
//                                         child:Text('$_imageFile')
//                               ),
//                               GestureDetector(
//                                 onTap: () {

//                                   // Navigator.of(context)
//                                   //     .pushNamed(StartDelivery.tag);
//                                 },
//                                 child: new Container(
//                                   padding: EdgeInsets.only(top: 6.0, left: 6.0),
//                                   width: 60.0,
//                                   height: 30.0,
//                                   decoration: BoxDecoration(
//                                       gradient: LinearGradient(
//                                         begin: Alignment.topLeft,
//                                         end: Alignment.bottomLeft,
//                                         stops: [
//                                           0.1,
//                                           0.5,
//                                         ],
//                                         colors: [
//                                           Color(0xFFf7f7f7),
//                                           Color(0xFFe1e1e1)
//                                         ],
//                                       ),
//                                       border: Border.all(
//                                           color: Color(0xFF38707070))),
//                                   child: new Text(
//                                     'Upload',
//                                     style: textlightblack(),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           )
// //
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
          },
          child: Container(
            color: redbtn,
            height: 50.0,
            alignment: AlignmentDirectional.center,
            child: Text(
              "Order Picked",
              textAlign: TextAlign.center,
              style: textwhitesmall(),
            ),
          )),
    );
  }
}
