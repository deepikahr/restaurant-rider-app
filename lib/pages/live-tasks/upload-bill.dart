import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class BillUpload extends StatefulWidget {
  final orderDetail;
  BillUpload({Key key, this.orderDetail}) : super(key: key);
  @override
  _BillUploadState createState() => _BillUploadState();
}

class _BillUploadState extends State<BillUpload> {
  static File _imageFile, myfile;
  void _getImage(BuildContext context, ImageSource source) {
    setState(() {
      _imageFile = myfile;
    });
    ImagePicker.pickImage(
      source: source,
    ).then((File image) {
      setState(() {
        _imageFile = image;
        // print(' mmmmmmmmmmmmmmmmmmm$_imageFile');
      });
    });
  }

  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        iconTheme: IconThemeData(color: Colors.white),
        title: new Text('Upload Bill', style: textwhitesmall()),
      ),
      body: new Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: new Text(
                    'Submit Bill',
                    style: textmediumb(),
                  ),
                ),
                // Expanded(
                //     child: new Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: <Widget>[
                //     GestureDetector(
                //       onTap: () {
                //         Navigator.of(context).pop(context);
                //       },
                //       child: new Icon(
                //         Icons.clear,
                //       ),
                //     )
                //   ],
                // )),
              ],
            ),
            InkWell(
              child: new Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                child: new Text(
                  'Camera',
                  style: textmediumblue(),
                ),
              ),
              onTap: () {
                _getImage(context, ImageSource.camera);
              },
            ),

            new Row(
              children: <Widget>[
                new Container(
                    width: 120.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                        color: bglight,
                        border: Border.all(color: Color(0xFF38707070))),
                    child: Text('$_imageFile')),
                GestureDetector(
                  onTap: () {
                    // Navigator.of(context)
                    //     .pushNamed(StartDelivery.tag);
                  },
                  child: new Container(
                    padding: EdgeInsets.only(top: 6.0, left: 6.0),
                    width: 60.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomLeft,
                          stops: [
                            0.1,
                            0.5,
                          ],
                          colors: [Color(0xFFf7f7f7), Color(0xFFe1e1e1)],
                        ),
                        border: Border.all(color: Color(0xFF38707070))),
                    child: new Text(
                      'Upload',
                      style: textlightblack(),
                    ),
                  ),
                )
              ],
            )
//
          ],
        ),
      ),
    );
  }
}
