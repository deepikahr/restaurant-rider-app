import 'package:delivery_app/services/localizations.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class BillUpload extends StatefulWidget {
  final orderDetail;
  final Map<String, Map<String, String>> localizedValues;
  final String locale;

  BillUpload({Key key, this.orderDetail, this.locale, this.localizedValues})
      : super(key: key);
  @override
  _BillUploadState createState() => _BillUploadState();
}

class _BillUploadState extends State<BillUpload> {
  static File _imageFile, myfile;
  void _getImage(BuildContext context, ImageSource source) {
    if (mounted) {
      setState(() {
        _imageFile = myfile;
      });
    }
    ImagePicker.pickImage(
      source: source,
    ).then((File image) {
      if (mounted) {
        setState(() {
          _imageFile = image;
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        iconTheme: IconThemeData(color: Colors.white),
        title: new Text(MyLocalizations.of(context).getLocalizations("UPLOAD_BILL"),
            style: textwhitesmall()),
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
                    MyLocalizations.of(context).getLocalizations("SUBMIT_BILL"),
                    style: textmediumb(),
                  ),
                ),
              ],
            ),
            InkWell(
              child: new Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                child: new Text(
                  MyLocalizations.of(context).getLocalizations("CAMERA"),
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
                  onTap: () {},
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
                      MyLocalizations.of(context).getLocalizations("UPLOAD"),
                      style: textlightblack(),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
