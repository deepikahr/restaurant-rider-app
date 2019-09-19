import 'package:delivery_app/pages/home/home.dart';
import 'package:flutter/material.dart';
import '../../styles/styles.dart';
import '../../services/profile-service.dart';
import 'package:async_loader/async_loader.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:async/async.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  File file;
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      GlobalKey<AsyncLoaderState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> profileData;
  bool isLoading = false;
  Image selectedImage;
  String base64Image;
  bool isPicUploading = false;

  Future<Map<String, dynamic>> getProfileInfo() async {
    return await ProfileService.getUserInfo();
  }

  void _saveProfileInfo() {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      _formKey.currentState.save();
      print("save button $profileData");

      ProfileService.setUserInfo(profileData['_id'], profileData)
          .then((onValue) {
        setState(() {
          isLoading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomePage(),
          ),
        );
      });
    }
  }

  static File _imageFile;

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
        profileData['_id'],
      );
      setState(() {
        isPicUploading = false;
      });
      // await ProfileService.setUserInfo(profileData['_id'], {
      //   'publicId': imageData['public_id'],
      //   'logo': imageData['url']
      // }).then((onValue) {
      //   setState(() {
      //     isPicUploading = false;
      //   });
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    AsyncLoader _asyncLoader = AsyncLoader(
        key: _asyncLoaderState,
        initState: () async => await getProfileInfo(),
        renderLoad: () => Center(child: CircularProgressIndicator()),
        renderError: ([error]) =>
            Text('Please check your internet connection!'),
        renderSuccess: ({data}) {
          profileData = data;
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
                    child: _imageFile == null
                        ? profileData['logo'] != null
                            ? new CircleAvatar(
                                backgroundImage:
                                    new NetworkImage("${profileData['logo']}"),
                              )
                            : new CircleAvatar(
                                backgroundImage:
                                    new AssetImage('assets/imgs/dp.jpg'))
                        : new CircleAvatar(
                            backgroundImage: new FileImage(_imageFile),
                            radius: 80.0,
                          ),
                  ),
                  title: Row(
                    children: [
                      RaisedButton(
                        color: Colors.lightBlue,
                        onPressed: _choose,
                        child: Text(
                          "Change",
                          style: textOS(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                      ),
                      isPicUploading
                          ? RaisedButton(
                              onPressed: () {},
                              color: Colors.lightBlue,
                              child: Image.asset(
                                'assets/icons/spinner.gif',
                                width: 19.0,
                                height: 19.0,
                              ),
                            )
                          : RaisedButton(
                              onPressed: _upload,
                              color: Colors.lightBlue,
                              child: Text(
                                "Upload",
                                style: textOS(),
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
                          border: Border.all(color: Colors.grey, width: 1.0),
                        ),
                        child: TextFormField(
                          onSaved: (value) {
                            data['name'] = value;
                          },
                          initialValue: data['name'],
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
                          border: Border.all(color: Colors.grey, width: 1.0),
                        ),
                        child: TextFormField(
                          onSaved: (value) {
                            data['contactNumber'] = value;
                          },
                          initialValue: data['contactNumber'].toString(),
                          decoration: new InputDecoration(
                            labelText: 'Mobile No.',
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
                          border: Border.all(color: Colors.grey, width: 1.0),
                        ),
                        child: TextFormField(
                          onSaved: (value) {
                            data['locationName'] = value;
                          },
                          initialValue: data['locationName'],
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
                          border: Border.all(color: Colors.grey, width: 1.0),
                        ),
                        child: TextFormField(
                          onSaved: (value) {
                            data['state'] = value;
                          },
                          initialValue: data['state'],
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
                          border: Border.all(color: Colors.grey, width: 1.0),
                        ),
                        child: TextFormField(
                          onSaved: (value) {
                            data['country'] = value;
                          },
                          initialValue: data['country'],
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
                          border: Border.all(color: Colors.grey, width: 1.0),
                        ),
                        child: TextFormField(
                          onSaved: (value) {
                            data['zip'] = value;
                          },
                          initialValue:
                              data['zip'] != null ? data['zip'].toString() : '',
                          decoration: new InputDecoration(
                            labelText: 'Post Code',
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
                            border: Border.all(color: Colors.grey, width: 1.0),
                          ),
                          child: new Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: new TextFormField(
                              onSaved: (value) {
                                data['address'] = value;
                              },
                              initialValue: data['address'],
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
                  ),
                ),
              ),
            ],
          );
        });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text("Profile"),
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
              color: primary,
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
