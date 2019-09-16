import 'package:delivery_app/pages/home/home.dart';
import 'package:delivery_app/services/auth.dart';
import 'package:delivery_app/services/orders-service.dart';
import 'package:delivery_app/services/profile-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import '../../styles/styles.dart';

import 'package:async_loader/async_loader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:async/async.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  static String tag = 'settings';
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => new _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name;
  String email, profileImage, contactNumber, address;
  int mobileNumber;
  String nameInitial;
  String emailInitial;
  String mobileInitial;
  var userData;
  bool loading = false, isPicUploading = false, isLoading = false;

  String getLang, gender;

  fetchUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await getUserInfo().then((response) {
      final int statusCode = response.statusCode;
      // print('uinfooo ${json.decode(response.body)}');
      userData = json.decode(response.body);
      // print(userData['logo']);

      if (statusCode != 200 || json == null) {
        throw new Exception("Error while fetching data");
      }
    });
  }

  void _saveProfileInfo() {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      _formKey.currentState.save();
      // print(userData);
      ProfileService.setUserInfo(userData['_id'], userData).then((onValue) {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      });
    }
  }

  static File _imageFile;
  Image selectedImage;
  String base64Image;
  void _choose() async {
    var file = await ImagePicker.pickImage(source: ImageSource.gallery);
    // base64Image = base64Encode(file.readAsBytesSync());
    setState(() {
      _imageFile = file;
    });
  }

  void _upload() async {
    setState(() {
      isPicUploading = true;
    });
    if (_imageFile != null) {
      var stream =
          new http.ByteStream(DelegatingStream.typed(_imageFile.openRead()));
      Map<String, dynamic> body = {"baseKey": base64Image};
      Map<String, dynamic> imageData;
      await ProfileService.uploadProfileImage(
        _imageFile,
        stream,
        userData['_id'],
      );
      setState(() {
        isPicUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var _asyncLoader = new AsyncLoader(
        key: _asyncLoaderState,
        initState: () async => await fetchUserInfo(),
        renderLoad: () => Center(
                child: new CircularProgressIndicator(
              backgroundColor: Colors.black,
            )),
        renderError: ([error]) =>
            new Text('Sorry, there was an error loading...'),
        renderSuccess: ({data}) {
          return ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        new BoxShadow(
                          blurRadius: 3.0,
                        ),
                      ],
                      border: Border(
                        top: BorderSide(color: Colors.grey, width: 1.5),
                        bottom: BorderSide(color: Colors.grey, width: 1.5),
                      )),
                  child: ListTile(
                    leading: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: new BoxDecoration(
                        border: new Border.all(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      // child: null
                      child: _imageFile == null
                          ? userData['logo'] != null
                              ? new CircleAvatar(
                                  backgroundImage:
                                      new NetworkImage("${userData['logo']}"),
                                )
                              : new CircleAvatar(
                                  backgroundImage:
                                      new AssetImage('assets/imgs/dp.png'))
                          : new CircleAvatar(
                              backgroundImage: new FileImage(_imageFile),
                              radius: 80.0,
                            ),
                    ),
                    title: Row(
                      children: [
                        RaisedButton(
                          // color: primaryLight,
                          onPressed: _choose,
                          child: Text(
                            "Change",
                            // style: textOS(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.0),
                        ),
                        isPicUploading
                            ? RaisedButton(
                                onPressed: () {},
                                // color: primaryLight,
                                child: Image.asset(
                                  'assets/icons/spinner.gif',
                                  width: 19.0,
                                  height: 19.0,
                                ),
                              )
                            : RaisedButton(
                                onPressed: _upload,
                                // color: primaryLight,
                                child: Text(
                                  "Upload",
                                  // style: textOS(),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                new Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 20.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
                              ),
                              child: TextFormField(
                                onSaved: (value) {
                                  userData['name'] = value;
                                },
                                initialValue: userData['name'],
                                decoration: new InputDecoration(
                                  labelText: 'Full Name',
                                  hintStyle: textOS(),
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
                              ),
                              child: TextFormField(
                                onSaved: (value) {
                                  userData['contactNumber'] = value;
                                },
                                initialValue:
                                    userData['contactNumber'].toString(),
                                decoration: new InputDecoration(
                                  labelText: 'Mobile No.',
                                  hintStyle: textOS(),
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
                              ),
                              child: TextFormField(
                                onSaved: (value) {
                                  userData['locationName'] = value;
                                },
                                initialValue: userData['locationName'],
                                decoration: new InputDecoration(
                                  labelText: 'Suburb',
                                  hintStyle: textOS(),
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
                              ),
                              child: TextFormField(
                                onSaved: (value) {
                                  userData['state'] = value;
                                },
                                initialValue: userData['state'],
                                decoration: new InputDecoration(
                                  labelText: 'State',
                                  hintStyle: textOS(),
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
                              ),
                              child: TextFormField(
                                onSaved: (value) {
                                  userData['country'] = value;
                                },
                                initialValue: userData['country'],
                                decoration: new InputDecoration(
                                  labelText: 'Country',
                                  hintStyle: textOS(),
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
                              ),
                              child: TextFormField(
                                onSaved: (value) {
                                  userData['zip'] = value;
                                },
                                initialValue: userData['zip'] != null
                                    ? userData['zip'].toString()
                                    : '',
                                decoration: new InputDecoration(
                                  labelText: 'Post Code',
                                  hintStyle: textOS(),
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 10.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 1.0),
                                ),
                                child: new Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: new TextFormField(
                                    onSaved: (value) {
                                      userData['address'] = value;
                                    },
                                    initialValue: userData['address'],
                                    decoration: new InputDecoration(
                                        labelText: 'Address',
                                        hintStyle: textOS(),
                                        fillColor: Colors.black,
                                        border: InputBorder.none),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 3,
                                  ),
                                )),
                          ],
                        )))
              ]);
        });

    return new Scaffold(
      // backgroundColor: Colors.black,
      appBar: new AppBar(
        backgroundColor: primary,
        iconTheme: IconThemeData(color: Colors.white),
        title: new Text('profile', style: textwhitesmall()),
        // title: Text(title, style: textwhitesmall()),
      ),
      body: _asyncLoader,
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: new Row(
        children: <Widget>[
          Expanded(
            child: new Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              height: 40.0,
              child: FlatButton(
                child: Text(
                  'Cancel',
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          new Padding(padding: EdgeInsets.all(5.0)),
          Expanded(
            child: new Container(
              height: 40.0,
              color: Colors.lightBlue,
              child: isLoading
                  ? Image.asset(
                      'assets/icons/spinner.gif',
                      width: 19.0,
                      height: 19.0,
                    )
                  : FlatButton(
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _saveProfileInfo();
                      },
                    ),
            ),
          )
        ],
      ),
    );
  }
}
