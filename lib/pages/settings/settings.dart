import 'package:delivery_app/pages/home/home.dart';
import 'package:delivery_app/services/auth.dart';
import 'package:delivery_app/services/orders-service.dart';
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

class Settings extends StatefulWidget {
  static String tag = 'settings';
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => new _SettingsState();
}

class _SettingsState extends State<Settings> {
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
  bool loading = false;

  String getLang, gender;

  static File _imageFile;

  takeImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _imageFile = image;
    });
    // print(_imageFile);
  }

  selectImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = image;
    });
  }

  fetchUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await getUserInfo().then((response) {
      final int statusCode = response.statusCode;
      print('uinfooo ${json.decode(response.body)}');
      userData = json.decode(response.body);

      if (statusCode != 200 || json == null) {
        throw new Exception("Error while fetching data");
      }
    });
  }

  //update userInfo
  onUpdateHandler() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      return;
    } else if (_imageFile != null) {
      form.save();
      setState(() {
        loading = true;
      });
      var stream =
          new http.ByteStream(DelegatingStream.typed(_imageFile.openRead()));
      updateUserAllInfo(name, email, mobileNumber, userData['_id'], _imageFile,
          stream, gender);
      if (accountUpdate) {
        showDialog<Null>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text('Updated'),
              content: new SingleChildScrollView(
                child: new ListBody(
                  children: <Widget>[
                    new Text('Your Profile has been updated!!'),
                  ],
                ),
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text(
                    'okay',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(HomePage.tag);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
      setState(() {
        loading = false;
      });
    } else {
      form.save();
      setState(() {
        loading = true;
      });
      updateUserInfo(name, email, mobileNumber, userData['_id'])
          .then((response) {
        String res = response.body;
        var data = json.decode(res);

        print(data);
        final int statusCode = response.statusCode;
        if (statusCode != 200 || json == null) {
          throw new Exception("Error while fetching data");
        } else {
          showDialog<Null>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return new AlertDialog(
                title: new Text('Updated'),
                content: new SingleChildScrollView(
                  child: new ListBody(
                    children: <Widget>[
                      new Text('Your Profile has been updated'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text(
                      'okay',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(HomePage.tag);
                    },
                  ),
                ],
              );
            },
          );
        }
      });
      setState(() {
        loading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var _asyncLoader = new AsyncLoader(
      key: _asyncLoaderState,
      initState: () async => await fetchUserInfo(),
      renderLoad: () => new CircularProgressIndicator(),
      renderError: ([error]) =>
          new Text('Sorry, there was an error loading...'),
      renderSuccess: ({data}) => SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: new Form(
          key: _formKey,
          child: new Theme(
            data: new ThemeData(
              brightness: Brightness.dark,
              accentColor: primary,
              inputDecorationTheme: new InputDecorationTheme(
                labelStyle: new TextStyle(
                  color: primary,
                  fontSize: 16.0,
                ),
              ),
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Center(
                  child: Container(
                    height: 150.0,
                    width: 150.0,
                    decoration: new BoxDecoration(
                      border: new Border.all(color: primary, width: 2.0),
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                    child: _imageFile == null
                        ? userData['imageUrl'] != null
                            ? new CircleAvatar(
                                backgroundImage:
                                    new NetworkImage("${userData['imageUrl']}"),
                              )
                            : new CircleAvatar(
                                backgroundImage:
                                    new AssetImage('assets/imgs/dp.png'))
                        : new CircleAvatar(
                            backgroundImage: new FileImage(_imageFile),
                            radius: 80.0,
                          ),
                  ),
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Flexible(
                      child: new FloatingActionButton(
                        foregroundColor: primary,
                        backgroundColor: Colors.white12,
                        onPressed: () => null,
                        tooltip: 'Take Photo',
                        child: new Icon(Icons.camera_alt),
                      ),
                    ),
                    new Flexible(
                      child: new FloatingActionButton(
                        foregroundColor: primary,
                        backgroundColor: Colors.white12,
                        onPressed: () => null,
                        tooltip: 'Select Photo',
                        child: new Icon(Icons.image),
                      ),
                    ),
                  ],
                ),
                new Padding(
                  padding: new EdgeInsetsDirectional.only(bottom: 15.0),
                ),
//                     new Container(
// //                  padding: const EdgeInsets.all(5.0),
//                       margin: const EdgeInsets.all(5.0),
//                       decoration: new BoxDecoration(
//                         border: new Border.all(
//                           color: Colors.transparent,
//                         ),
//                         borderRadius: new BorderRadius.only(
//                           topLeft: const Radius.circular(5.0),
//                           topRight: const Radius.circular(5.0),
//                           bottomLeft: const Radius.circular(5.0),
//                           bottomRight: const Radius.circular(5.0),
//                         ),
//                         color: Colors.white12,
//                       ),
//                       alignment: FractionalOffset.center,
//                       child: new ListTile(
//                         title: new Text(
//                           'Select Language',
//                           style: new TextStyle(
//                               fontSize: 16.0,
//                               color: primary,
//                               fontWeight: FontWeight.w400),
//                         ),
//                         trailing: new DropdownButton<String>(
//                           value: _languageSelection,
//                           items: languagedropdownMenuOptions,
//                           onChanged: (s) => selectLang(s),
//                         ),
//                       ),
//                     ),
                new Container(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  margin: const EdgeInsets.all(5.0),
                  decoration: new BoxDecoration(
                    border: new Border.all(
                      color: Colors.transparent,
                    ),
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(5.0),
                      topRight: const Radius.circular(5.0),
                      bottomLeft: const Radius.circular(5.0),
                      bottomRight: const Radius.circular(5.0),
                    ),
                    color: Colors.white12,
                  ),
                  alignment: FractionalOffset.center,
                  child: new TextFormField(
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      // labelText:
                      //     FlutterI18n.translate(context, "User Name"),
                      labelText: 'User Name',
                      icon: new Icon(Icons.person),
                    ),
                    initialValue: '${userData['name']}',
                    validator: (String value) {
                      final RegExp nameExp = new RegExp(r'^[A-Za-z ]+$');
                      if (value.isEmpty || !nameExp.hasMatch(value)) {
                        return 'Please enter your name';
                      }
                    },
                    onSaved: (String value) {
                      name = value;
                    },
                    keyboardType: TextInputType.text,
                  ),
                ),
                new Container(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  margin: const EdgeInsets.all(5.0),
                  decoration: new BoxDecoration(
                    border: new Border.all(
                      color: Colors.transparent,
                    ),
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(5.0),
                      topRight: const Radius.circular(5.0),
                      bottomLeft: const Radius.circular(5.0),
                      bottomRight: const Radius.circular(5.0),
                    ),
                    color: Colors.white12,
                  ),
                  alignment: FractionalOffset.center,
                  child: new TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Email ID",
                      icon: new Icon(Icons.mail),
                      border: InputBorder.none,
                    ),
                    initialValue: '${userData['email']}',
                    validator: (String value) {
                      if (value.isEmpty ||
                          !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                              .hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                    },
                    onSaved: (String value) {
                      email = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                new Container(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  margin: const EdgeInsets.all(5.0),
                  decoration: new BoxDecoration(
                    border: new Border.all(
                      color: Colors.transparent,
                    ),
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(5.0),
                      topRight: const Radius.circular(5.0),
                      bottomLeft: const Radius.circular(5.0),
                      bottomRight: const Radius.circular(5.0),
                    ),
                    color: Colors.white12,
                  ),
                  alignment: FractionalOffset.center,
                  child: new TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Mobile Number",
                      icon: new Icon(Icons.phone),
                      border: InputBorder.none,
                    ),
                    initialValue: '${userData['contactNumber']}',
                    validator: (String value) {
                      if (value.length != 10)
                        return 'Mobile Number must be of 10 digit';
                      else
                        return null;
                    },
                    onSaved: (String value) {
                      mobileNumber = int.parse(value);
                    },
                    keyboardType: TextInputType.number,
                  ),
                ),
                new Padding(
                  padding: const EdgeInsetsDirectional.only(
                      top: 30.0, start: 20.0, end: 20.0),
                  child: new MaterialButton(
                    color: primary,
                    textColor: Colors.white,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // new Text(FlutterI18n.translate(context, "Save"),
                        new Text("Save", style: subTitleWhite()),
                        new Padding(
                            padding:
                                new EdgeInsets.only(left: 5.0, right: 5.0)),
                        // loading
                        //     ? new Image.asset(
                        //         'assets/spinner.gif',
                        //         width: 19.0,
                        //         height: 19.0,
                        //       )
                        //     : new Text(''),
                      ],
                    ),
                    onPressed: onUpdateHandler,
                    splashColor: secondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
        title: new Text(
          "Settings",
          style: subTitleWhite(),
        ),
        backgroundColor: Colors.black,
        iconTheme: new IconThemeData(color: Colors.white),
        actions: <Widget>[],
      ),
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Center(
            child: _asyncLoader,
          ),
        ],
      ),
    );
  }
}
