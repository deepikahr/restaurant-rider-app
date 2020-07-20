import 'package:delivery_app/main.dart';
import 'package:delivery_app/pages/auth/login.dart';
import 'package:delivery_app/pages/home/home.dart';
import 'package:delivery_app/pages/profile/profile.dart';
import 'package:delivery_app/services/auth-service.dart';
import 'package:delivery_app/services/constant.dart';
import 'package:delivery_app/services/localizations.dart' show MyLocalizations;
import 'package:flutter/material.dart';
import 'package:delivery_app/styles/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerPage extends StatefulWidget {
  final Map<String, Map<String, String>> localizedValues;
  final String locale;

  DrawerPage({Key key, this.locale, this.localizedValues}) : super(key: key);
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  String name,
      email,
      profileImage,
      gender,
      picture,
      selectedLanguages,
      selectedLang;
  List<String> languages = ['English', 'French', 'Arabic', 'Chinese'];
  var userData, selectedLanguage, selectedLocale;
  @override
  void initState() {
    super.initState();
    getData();
    userInformation();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        selectedLanguage = prefs.getString('selectedLanguage');
      });
      if (selectedLanguage == 'en') {
        selectedLocale = 'English';
      } else if (selectedLanguage == 'fr') {
        selectedLocale = 'French';
      } else if (selectedLanguage == 'ar') {
        selectedLocale = 'Arabic';
      } else if (selectedLanguage == 'zh') {
        selectedLocale = 'Chinese';
      }
    }
  }

  void userInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("name") != null || prefs.getString("picture") != null) {
      picture = prefs.getString("picture");
      name = prefs.getString("name");
    }
    await AuthService.getUserInfo().then((response) {
      if (mounted) {
        setState(() {
          prefs.setString("name", response['name']);
          prefs.setString("picture", response['logo']);
          name = response['name'] ?? "";
          picture = response['logo'];
        });
      }
    });
  }

  Widget _buildMenuProfileLogo(String imgUrl) {
    return Padding(
      padding: EdgeInsets.only(top: 30.0, bottom: 10.0),
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: new BoxDecoration(
          border: new Border.all(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(80.0),
        ),
        child: imgUrl == null
            ? new CircleAvatar(
                backgroundImage: new AssetImage('assets/imgs/na.jpg'))
            : new CircleAvatar(
                backgroundImage: new NetworkImage(imgUrl),
                radius: 80.0,
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: Center(
          child: new ListView(
            children: <Widget>[
              Stack(
                fit: StackFit.passthrough,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: new Column(
                      children: <Widget>[
                        new Padding(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: Column(
                              children: <Widget>[
                                new Image.asset(
                                  'assets/imgs/logo.png',
                                  width: 150.0,
                                  height: 100.0,
                                ),
                                Text(APP_NAME)
                              ],
                            )),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => Profile(
                                  locale: widget.locale,
                                  localizedValues: widget.localizedValues,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 5.0, right: 12.0),
                            padding: EdgeInsets.only(left: 12.0, right: 12.0),
                            decoration: BoxDecoration(
                                border: Border(
                              top: BorderSide(width: 1.0),
                              bottom: BorderSide(width: 1.0),
                            )),
                            child: Row(
                              children: <Widget>[
                                _buildMenuProfileLogo(picture),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 20.0, right: 20.0),
                                ),
                                name != null
                                    ? Text(
                                        name.toUpperCase(),
                                      )
                                    : Container(height: 0, width: 0),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => HomePage(
                                    locale: widget.locale,
                                    localizedValues: widget.localizedValues,
                                    currentIndex: 0,
                                  ),
                                ),
                                (Route<dynamic> route) => false);
                          },
                          child: new ListTile(
                            contentPadding:
                                EdgeInsets.only(left: 36.0, right: 20.0),
                            leading: Image.asset(
                              'assets/icons/home.png',
                              color: primary,
                            ),
                            title: new Text(
                              MyLocalizations.of(context).getLocalizations("HOME"),
                            ),
                            trailing: new Icon(
                              Icons.chevron_right,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => HomePage(
                                    locale: widget.locale,
                                    localizedValues: widget.localizedValues,
                                    currentIndex: 1,
                                  ),
                                ),
                                (Route<dynamic> route) => false);
                          },
                          child: new ListTile(
                            contentPadding:
                                EdgeInsets.only(left: 36.0, right: 20.0),
                            leading: new Icon(
                              Icons.attach_money,
                              color: primary,
                            ),
                            title: new Text(
                              MyLocalizations.of(context).getLocalizations("EARNINGS"),
                            ),
                            trailing: new Icon(
                              Icons.chevron_right,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => HomePage(
                                    locale: widget.locale,
                                    localizedValues: widget.localizedValues,
                                    currentIndex: 2,
                                  ),
                                ),
                                (Route<dynamic> route) => false);
                          },
                          child: new ListTile(
                            contentPadding:
                                EdgeInsets.only(left: 36.0, right: 20.0),
                            leading: new Image.asset(
                              'assets/icons/order.png',
                              color: primary,
                            ),
                            title: new Text(
                              MyLocalizations.of(context).getLocalizations("ORDERS"),
                            ),
                            trailing: new Icon(
                              Icons.chevron_right,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            pref.remove('token');
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Login(
                                    locale: widget.locale,
                                    localizedValues: widget.localizedValues,
                                  ),
                                ),
                                (Route<dynamic> route) => false);
                          },
                          child: new ListTile(
                            contentPadding:
                                EdgeInsets.only(left: 36.0, right: 20.0),
                            leading: new Icon(
                              Icons.exit_to_app,
                              color: primary,
                            ),
                            title: new Text(
                              MyLocalizations.of(context).getLocalizations("LOGOUT"),
                            ),
                            trailing: new Icon(
                              Icons.chevron_right,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.0),
                          ),
                          child: ListTile(
                            title: Text(
                                MyLocalizations.of(context).getLocalizations("SELECT_LANGUAGES")),
                            trailing: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: Text(selectedLocale == null
                                    ? 'English'
                                    : selectedLocale),
                                value: selectedLanguages,
                                onChanged: (newValue) async {
                                  if (newValue == 'English') {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString('selectedLanguage', 'en');
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              MyApp(
                                            "en",
                                            widget.localizedValues,
                                          ),
                                        ),
                                        (Route<dynamic> route) => false);
                                  } else if (newValue == 'Arabic') {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString('selectedLanguage', 'ar');

                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              MyApp(
                                            "ar",
                                            widget.localizedValues,
                                          ),
                                        ),
                                        (Route<dynamic> route) => false);
                                  } else if (newValue == 'Chinese') {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString('selectedLanguage', 'zh');
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              MyApp(
                                            "zh",
                                            widget.localizedValues,
                                          ),
                                        ),
                                        (Route<dynamic> route) => false);
                                  } else {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString('selectedLanguage', 'fr');
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              MyApp(
                                            "fr",
                                            widget.localizedValues,
                                          ),
                                        ),
                                        (Route<dynamic> route) => false);
                                  }
                                },
                                items: languages.map((lang) {
                                  return DropdownMenuItem(
                                    child: new Text(lang),
                                    value: lang,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
