import 'dart:io';

import 'package:async/async.dart';
import 'package:delivery_app/services/localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

import '../../services/profile-service.dart';
import '../../styles/styles.dart';

class Profile extends StatefulWidget {
  final Map<String, Map<String, String>> localizedValues;
  final String locale;

  Profile({Key key, this.locale, this.localizedValues}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  File file;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false, isPicUploading = false, isProfileLoading = false;
  Map userDetails;

  getProfileInfo() async {
    if (mounted) {
      setState(() {
        isProfileLoading = true;
      });
    }

    await ProfileService.getUserInfo().then((value) {
      if (mounted) {
        setState(() {
          userDetails = value;
          isProfileLoading = false;
        });
      }
    });
  }

  @override
  void initState() {
    getProfileInfo();
    super.initState();
  }

  void _saveProfileInfo() {
    if (_formKey.currentState.validate()) {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }
      _formKey.currentState.save();
      var body = {
        "name": userDetails['name'],
        "contactNumber": userDetails['contactNumber'],
      };
      ProfileService.setUserInfo(userDetails['_id'], body).then((onValue) {
        Toast.show(
            MyLocalizations.of(context).yourprofileSuccessfullyUPDATED, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      });
    }
  }

  File _imageFile;

  void selectGallary() async {
    var file = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (mounted) {
      setState(() {
        _imageFile = file;
        if (mounted) {
          setState(() {
            isPicUploading = true;
          });
        }
        if (_imageFile != null) {
          var stream = new http.ByteStream(
              DelegatingStream.typed(_imageFile.openRead()));

          ProfileService.uploadProfileImage(
            _imageFile,
            stream,
            userDetails['_id'],
          );
          if (mounted) {
            setState(() {
              isPicUploading = false;
            });
          }
          Toast.show(
              MyLocalizations.of(context).yourprofilePictureSuccessfullyUPDATED,
              context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM);
        }
      });
    }
  }

  void selectCamera() async {
    var file = await ImagePicker.pickImage(source: ImageSource.camera);
    if (mounted) {
      setState(() {
        _imageFile = file;
        if (mounted) {
          setState(() {
            isPicUploading = true;
          });
        }
        if (_imageFile != null) {
          var stream = new http.ByteStream(
              DelegatingStream.typed(_imageFile.openRead()));

          ProfileService.uploadProfileImage(
            _imageFile,
            stream,
            userDetails['_id'],
          );

          if (mounted) {
            setState(() {
              isPicUploading = false;
            });
          }
          Toast.show(
              MyLocalizations.of(context).yourprofilePictureSuccessfullyUPDATED,
              context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.BOTTOM);
        }
      });
    }
  }

  void removeProfilePic() async {
    if (mounted) {
      setState(() {
        isPicUploading = true;
      });
    }
    await ProfileService.deleteUserProfilePic().then((onValue) {
      Toast.show(onValue['message'], context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      userDetails['logo'] = null;
      _imageFile = null;
      if (mounted) {
        setState(() {
          isPicUploading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title:
            Text(MyLocalizations.of(context).profile, style: textwhitesmall()),
      ),
      body: isProfileLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: primary,
              ),
            )
          : ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Stack(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              height: 120.0,
                              width: 120.0,
                              decoration: new BoxDecoration(
                                border: new Border.all(
                                    color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(80.0),
                              ),
                              child: _imageFile == null
                                  ? userDetails['logo'] != null
                                      ? new CircleAvatar(
                                          backgroundImage: new NetworkImage(
                                              "${userDetails['logo']}"),
                                        )
                                      : new CircleAvatar(
                                          backgroundImage: new AssetImage(
                                              'assets/imgs/na.jpg'))
                                  : isPicUploading
                                      ? CircularProgressIndicator()
                                      : new CircleAvatar(
                                          backgroundImage:
                                              new FileImage(_imageFile),
                                          radius: 80.0,
                                        ),
                            ),
                          ),
                          Positioned(
                            right: 2.0,
                            bottom: 0.0,
                            child: Container(
                              height: 40.0,
                              width: 40.0,
                              child: new FloatingActionButton(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white,
                                onPressed: () {
                                  showDialog<Null>(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return new AlertDialog(
                                          title: new Text(
                                              MyLocalizations.of(context)
                                                  .changeprofilepicture),
                                          content: new SingleChildScrollView(
                                            child: new ListBody(
                                              children: <Widget>[
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          selectGallary();
                                                        },
                                                        child: new Text(
                                                            MyLocalizations.of(
                                                                    context)
                                                                .choosefromphotos),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          selectCamera();
                                                        },
                                                        child: new Text(
                                                            MyLocalizations.of(
                                                                    context)
                                                                .takephoto),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child:
                                                          userDetails['logo'] !=
                                                                  null
                                                              ? InkWell(
                                                                  onTap: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    removeProfilePic();
                                                                  },
                                                                  child: new Text(
                                                                      MyLocalizations.of(
                                                                              context)
                                                                          .removephoto),
                                                                )
                                                              : Container(),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            new FlatButton(
                                              child: new Text(
                                                  MyLocalizations.of(context)
                                                      .cancel),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                                tooltip: 'Photo',
                                child: new Icon(Icons.edit),
                              ),
                            ),
                          ),
                        ]),
                        Container(
                          margin: EdgeInsets.only(top: 20.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.0),
                          ),
                          child: TextFormField(
                            onSaved: (value) {
                              userDetails['name'] = value;
                            },
                            initialValue: userDetails['name'],
                            decoration: new InputDecoration(
                              labelText: MyLocalizations.of(context).fullName,
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
                              userDetails['contactNumber'] = value;
                            },
                            initialValue:
                                userDetails['contactNumber'].toString(),
                            decoration: new InputDecoration(
                              labelText:
                                  MyLocalizations.of(context).mobileNumber,
                              hintStyle: textOS(),
                              contentPadding: EdgeInsets.all(10.0),
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
                  MyLocalizations.of(context).cancel,
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
                        MyLocalizations.of(context).save,
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

  void containerForSheet<T>({BuildContext context, Widget child}) {
    showCupertinoModalPopup<T>(
      context: context,
      builder: (BuildContext context) => child,
    );
  }
}
